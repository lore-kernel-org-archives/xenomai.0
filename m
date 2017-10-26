From: Piotr Piorkowski <qba100@gmail.com>
Message-ID: <local-8a4e01bb-e3b0@nylas-mail.nylas.com>
Date: Thu, 26 Oct 2017 18:48:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [Xenomai] Xenomai 3.0.5 - Segmentation fault in xnsynch_sleep_on(); 
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai xenomai.org" <xenomai@xenomai.org>

   Hello

   I'm running rtdm kernel module using the xenomai 3.0.5 and Linux 4.1.21
   on RPi 3
   I have problem with spi-bcm2835 rtdm driver (from official
   xenomai kernel source).
   When I am using write function, I get segmentation fault.
   Problem is on xnsynch_sleep_on() function:  xnthread_current() retrun
   NULL.
   Best Regards
   Piotr PiA^3rkowski

   [05cd4d4c8919f560c95bcb85a4ccc92404cecc76ba3dced93a3fc9c290ffda0f]
