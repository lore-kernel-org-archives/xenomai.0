Message-ID: <46C0F888.5050405@domain.hid>
Date: Mon, 13 Aug 2007 19:34:16 -0500
From: Bill Gatliff <bgat@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] svn-buildpackage not working?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Guys:


Trying to put together a Xenomai package for my Debian "testing" PC.  It 
hangs here:

# svn co ...; cd xenomai
# svn-buildpackage -us -uc -rfakeroot
...
rm: cannot remove /root/xenomai/debian/tmp//usr/include/xenomai: Is a 
directory
make[4]: *** [install-data-local] Error 1


Any ideas?


Regards,


b.g.

-- 
Bill Gatliff
bgat@domain.hid



