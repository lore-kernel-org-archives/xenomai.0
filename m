Message-ID: <496F3A37.1000801@domain.hid>
Date: Thu, 15 Jan 2009 14:29:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BAY101-W2825402A319CC124388542EAD70@domain.hid>
	<496F2281.2000102@domain.hid>
	<BAY101-W14267D7B841C080C30386DEAD70@domain.hid>
In-Reply-To: <BAY101-W14267D7B841C080C30386DEAD70@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debugger Support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephen Davies <steve_davies61@domain.hid>
Cc: xenomai@xenomai.org

Stephen Davies wrote:
> Hi Jan,
>  
> Thanks for your quick reply.  Just to be clear I would be able to debug hard real time threads using GDB with no patches applied to it?  That would be a massive step forward for me!

Yes. Debugging real-time apps in general is not always straightforward.
So you may be forced to apply some smart methods to avoid gdb disturbing
your real-time constraints already before you get to the interesting
point. But this is (in most cases) nothing Xenomai specific.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

