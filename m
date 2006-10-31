Subject: Re: [Xenomai-help] Kernel OOps large appl.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D680@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D680@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 14:54:54 +0100
Message-Id: <1162302894.4996.81.camel@domain.hid>
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 13:25 +0000, Daniel Schnell wrote:
> Hi,
>  
> we are porting our application to the POSIX skin of Xenomai. We are
> using a 2.4.25 Denx based Kernel with 4 days old Xenomai 2.3-devel svn

Mm, 2.3-devel, so there is no UVM in the picture since the latter
support has been removed from the trunk/ in favour of the direct syscall
interfaces. But then, how do you emulate pSOS? Using your own
POSIX-based emulator (i.e. _not_ Xenomai's pSOS skin)?

-- 
Philippe.



