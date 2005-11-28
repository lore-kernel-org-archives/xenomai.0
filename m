From: Alexis Berlemont <alexis.berlemont@domain.hid>
Date: Mon, 28 Nov 2005 23:36:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511282336.49995.alexis.berlemont@domain.hid>
Subject: [Adeos-main] ipipe backport for 2.4
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi,

A backport of I-Pipe 2.6/x86 has been made for 2.4/x86. The patch is available 
at the following URL:

http://download.gna.org/adeos/patches/v2.4/i386/adeos-ipipe-2.4.31-i386-1.0-00.patch

All the I-Pipe stuff is quite similar to its big brother's. As a matter of 
fact, I-Pipe 2.4 is an adaptation of I-Pipe 2.6. I have tried to be as close 
as possible to the original implementation. Most of the changes are due to 
2.6 API evolutions. The handlers (irq, exception) have also been reviewed 
(argument marshalling is not used in 2.6).

Consequently, the 2.4 I-Pipe branch offers same functionnalities as 2.6's and 
their behaviours are nearly identical.

This patch has been tested on UP and SMP modes. 

 Regards.

Alexis.


