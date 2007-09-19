Message-ID: <1ce16a2c0709190643l31348293xc5bdd95c3c0680c7@domain.hid>
Date: Wed, 19 Sep 2007 15:43:28 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] write to pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi.
I've successfully got a pipe working with a loadable kernel module
that rpm attached in previous email.

I can write to /dev/rtp0 by simply 'echo foo > /dev/rtp0'

I do also write to serial in the same task.
The write section to write to pipe and write on rtser0 in my module.c
looks like:
rt_pipe_receive(&pipe_desc, &msgin, TM_INFINITE);
rt_pipe_alloc(&pipe_desc,P_MSGSIZE(msgin));
err=rt_dev_write(fd, P_MSGPTR(msgin), P_MSGSIZE(msgin));
rt_pipe_flush(&pipe_desc,0);
rt_pipe_free(&pipe_desc,msgin);

What I want to is that I want to write data quickly to the pipe, which
should buffer the written data to it.
Then the periodic module.c(kernel module) task should get the data
from the pipe and write it out every period.

This way I can assure that the is a buffer where the data get stored
first, and then it's periodically written out. Predictable...

Anyhow my problem at the moment is that when I do write to the device
file /dev/rtp0 quickly this get messed.

For example my java code which writes int:s 1..100 as quick as
possible to the devicefile.

If I run that java file all I get out from my kernel module which read
the pipe is maybe  "\0x00" which means only the first added int.

Of course this is not the behavior I'm looking for. :/

My java test code:
public class testa {

	private static FileOutputStream fos;
	public static void main(String[] args) {
		try {
			fos = new FileOutputStream(new File("/dev/rtp0"));
		} catch (Exception e) {
		}
		for (int i = 0; i < 100; i++) {
			try {
				fos.write(i);
				fos.flush();
			//	Thread.sleep(500);
			} catch (Exception e) {
			}
		}
		try{
		fos.close();
		}
		catch (Exception e){
		}
		}
	}

By the way, if I comment in the sleep everything works. Buf I don't
want to do that of course. I want the rttask(module) in kernelspace to
pick from a already available buffer.

I'm very grateful for any hints.
Bachman

