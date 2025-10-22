#!/usr/bin/env python3
"""
Test SMTP connection and email sending for Platon
Usage: ./test_smtp.py <from_addr> <to_addr> [smtp_server] [smtp_port]
"""

import sys
import smtplib
from email.message import EmailMessage
from datetime import datetime

def test_smtp(from_addr, to_addr, smtp_server="outbound-mta.it.sikt.no", smtp_port=587):
    """Test SMTP connection and send test email"""

    print("=== SMTP Connection Test ===")
    print(f"\nSMTP Server: {smtp_server}:{smtp_port}")
    print(f"From: {from_addr}")
    print(f"To: {to_addr}")
    print()

    # Check sender address domain
    valid_domains = ['@sikt.no', '@feide.no', '@sigma2.no']
    if not any(from_addr.endswith(domain) for domain in valid_domains):
        print(f"⚠️  Warning: From address should end with {', '.join(valid_domains)}")
        print("   Otherwise it will be rewritten to @srs.it.sikt.no")
        print()

    # Create test message
    msg = EmailMessage()
    msg['From'] = from_addr
    msg['To'] = to_addr
    msg['Subject'] = f'Test Email from Platon - {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}'
    msg.set_content(f"""
This is a test email sent from Platon infrastructure.

Test Details:
- SMTP Server: {smtp_server}:{smtp_port}
- From Address: {from_addr}
- To Address: {to_addr}
- Timestamp: {datetime.now().isoformat()}

If you received this email, the SMTP configuration is working correctly.
""")

    try:
        print("Connecting to SMTP server...")
        with smtplib.SMTP(smtp_server, smtp_port, timeout=10) as smtp:
            print("✓ Connected to SMTP server")

            print("Sending test email...")
            smtp.send_message(msg)
            print("✓ Email sent successfully")

            print()
            print("=== Test Successful ===")
            print(f"Check {to_addr} for the test email")
            return True

    except smtplib.SMTPException as e:
        print(f"❌ SMTP Error: {e}")
        return False
    except ConnectionRefusedError:
        print("❌ Connection refused")
        print("   Check SMTP server address and port")
        return False
    except TimeoutError:
        print("❌ Connection timeout")
        print("   Check network connectivity and firewall rules")
        return False
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        return False

def main():
    if len(sys.argv) < 3:
        print("Usage: ./test_smtp.py <from_addr> <to_addr> [smtp_server] [smtp_port]")
        print()
        print("Examples:")
        print("  ./test_smtp.py myapp@sikt.no recipient@example.com")
        print("  ./test_smtp.py noreply@sikt.no admin@sikt.no")
        print("  ./test_smtp.py app@feide.no test@example.com outbound-mta.it.sikt.no 587")
        sys.exit(1)

    from_addr = sys.argv[1]
    to_addr = sys.argv[2]
    smtp_server = sys.argv[3] if len(sys.argv) > 3 else "outbound-mta.it.sikt.no"
    smtp_port = int(sys.argv[4]) if len(sys.argv) > 4 else 587

    success = test_smtp(from_addr, to_addr, smtp_server, smtp_port)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
