Subject: Re: [Xenomai-help] Cleanup after using the vxWorks skin?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200610211628.21249.niklaus.giger@domain.hid>
References: <200610211628.21249.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 16:52:33 +0200
Message-Id: <1161442353.5017.23.camel@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Sat, 2006-10-21 at 16:28 +0200, Niklaus Giger wrote:
> Hi
> 
> I run a program using the vxworks skin from user space. As did hang, I 
> typed  "Ctrl-C" to end the program.
> 
> Looking at /proc/xenomai/registry/vxworks/semaphores/ I remarked however, that 
> there were still vxworks semaphores open, which had not been deleted.
> 
> Is it up to the programmer to clean up at exit? Or is this a bug in the 
> current Xenomai implementation?
> 

It's not a bug, but rather a limitation. We don't currently support
auto-cleanup of objects in the VxWorks skin.

-- 
Philippe.



