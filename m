From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17673.32941.706379.236825@domain.hid>
Date: Thu, 14 Sep 2006 18:17:49 +0200
Subject: Re: [Xenomai-help] inscrutable pipes
In-Reply-To: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
References: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ckreider <ckreider@domain.hid>
Cc: xenomai@xenomai.org

ckreider wrote:
 > Proud though I am, it is time to ask for help.  I have used pipes  
 > with RTLinux but want to use Xenomai this time.  I can't get pipes  
 > working.
 > 
 > (as an aside, I saw on here where if you do make install, it will  
 > create the necessary /dev/rtp* entries.  I work on a development host  
 > and do not compile on the target, so I do not run make install.  I  
 > finally found the mknod magic in a message on this list)

I work on a development host and do not compile on the target, but I use
make install: I simply set the DESTDIR variable so that the files are
installed in a temporary directory that I can then share by NFS, rsync
on the target, use to create an initrd or filesystem image, or anything
else. This is much simpler than using mknod.

-- 


					    Gilles Chanteperdrix.

