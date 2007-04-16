From: Jeff Weber <jweber@domain.hid>
Date: Mon, 16 Apr 2007 15:20:53 -0500
References: <200704161449.27506.jweber@domain.hid>
	<1176753934.15950.40.camel@domain.hid>
In-Reply-To: <1176753934.15950.40.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704161520.53584.jweber@domain.hid>
Subject: Re: [Xenomai-help] page faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai Help <xenomai@xenomai.org>

On Monday 16 April 2007 15:05, Philippe Gerum wrote:

> Could you disassemble the code around location 0x80fb8c5?
The latest version of my code has moved the the addresses a bit:
Xenomai: Switching mythread to secondary mode after exception #14 from user-space at 0x80fb8cd (pid 3590)

(gdb) disas
Dump of assembler code for function _ZN4AMSC8CRtDequeIcE9push_backERKc:
0x080fb8b4 <_ZN4AMSC8CRtDequeIcE9push_backERKc+0>:      push   %ebp
0x080fb8b5 <_ZN4AMSC8CRtDequeIcE9push_backERKc+1>:      mov    %esp,%ebp
0x080fb8b7 <_ZN4AMSC8CRtDequeIcE9push_backERKc+3>:      sub    $0x8,%esp
0x080fb8ba <_ZN4AMSC8CRtDequeIcE9push_backERKc+6>:      mov    0x8(%ebp),%edx
0x080fb8bd <_ZN4AMSC8CRtDequeIcE9push_backERKc+9>:      mov    0x8(%ebp),%eax
0x080fb8c0 <_ZN4AMSC8CRtDequeIcE9push_backERKc+12>:     mov    0x8(%eax),%eax
0x080fb8c3 <_ZN4AMSC8CRtDequeIcE9push_backERKc+15>:     mov    (%edx),%edx
0x080fb8c5 <_ZN4AMSC8CRtDequeIcE9push_backERKc+17>:     add    %eax,%edx
0x080fb8c7 <_ZN4AMSC8CRtDequeIcE9push_backERKc+19>:     mov    0xc(%ebp),%eax
0x080fb8ca <_ZN4AMSC8CRtDequeIcE9push_backERKc+22>:     movzbl (%eax),%eax
0x080fb8cd <_ZN4AMSC8CRtDequeIcE9push_backERKc+25>:     mov    %al,(%edx)
0x080fb8cf <_ZN4AMSC8CRtDequeIcE9push_backERKc+27>:     mov    0x8(%ebp),%eax
0x080fb8d2 <_ZN4AMSC8CRtDequeIcE9push_backERKc+30>:     add    $0x8,%eax
0x080fb8d5 <_ZN4AMSC8CRtDequeIcE9push_backERKc+33>:     mov    %eax,0x4(%esp)
0x080fb8d9 <_ZN4AMSC8CRtDequeIcE9push_backERKc+37>:     mov    0x8(%ebp),%eax
0x080fb8dc <_ZN4AMSC8CRtDequeIcE9push_backERKc+40>:     mov    %eax,(%esp)
0x080fb8df <_ZN4AMSC8CRtDequeIcE9push_backERKc+43>:     call   0x80fcb18 <_ZN4AMSC8CRtDequeIcE3incERi>

>
> > as well as the delivery of SIGXCPU to my application (at my request).
> >
> > How do I prevent this page fault?
> >
> > Is this issue covered by the recent NOCOW activity?
>
> Possibly. You need I-pipe 1.7-03 and Xenomai >= v2.3.1 to get the
> ondemand mapping scheme disabled by the nucleus when your thread starts.
I am not familiar with the purpose and implementation of the NOCOW patch.
How would the patch affect my page fault issue?

	thanks,
	Jeff

