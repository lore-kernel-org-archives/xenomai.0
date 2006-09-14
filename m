Subject: Re: [Xenomai-help] inscrutable pipes
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
References: <3BDC517D-07A0-4BD3-9C6A-332E76B32615@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 18:17:57 +0200
Message-Id: <1158250677.5040.199.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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

On Thu, 2006-09-14 at 12:06 -0400, ckreider wrote:
> Proud though I am, it is time to ask for help.  I have used pipes with
> RTLinux but want to use Xenomai this time.  I can't get pipes working.
> 
> 
> (as an aside, I saw on here where if you do make install, it will
> create the necessary /dev/rtp* entries.  I work on a development host
> and do not compile on the target, so I do not run make install.  I
> finally found the mknod magic in a message on this list)
> 
> 
> I am using Xenomai 2.2.1 with a 2.6.17.8 kernel.
> 

The message pipe support has been refactored recently to behave like
classic FIFOs when accessed through the /dev/rtp* interface. All changes
have been committed to our repos, and should be obtained from there
until we roll out v2.2.3.

You can get the code through SVN at this URL:
http://svn.gna.org/viewcvs/xenomai/branches/v2.2.x/

Could you try it, and let us know if it solves the issue you raised?
TIA,

-- 
Philippe.



