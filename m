Message-ID: <02b61548f11b624ae3f5330b1564a038.squirrel@domain.hid>
Date: Wed, 13 Oct 2010 08:08:11 +0200
From: "Cagnulein" <cagnulein@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20101013080811_18666"
Subject: Re: [Xenomai-help] HELP: Real-time Drivers
Reply-To: cagnulein@domain.hid
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

------=_20101013080811_18666
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

> On 13/10/2010 06:19, Peter Warner wrote:
> Dear Xenomai Users,
>
> I want to develop the real-time driver for my UART(RS-232) can any one
> please Suggest How can I develop it.
> Can I get Example Code and what are the different API I need to use.
> What are the Different Compilation and Linker flag I need to use.
Hi, you can see the example provided with xenomai under ksrc
<http://git.xenomai.org/?p=xenomai-2.5.git;a=tree;f=ksrc;hb=14c921b86a82debe367c782b33273f8ba470cf6e>
/ drivers
<http://git.xenomai.org/?p=xenomai-2.5.git;a=tree;f=ksrc/drivers;hb=14c921b86a82debe367c782b33273f8ba470cf6e>
/ serial
<http://git.xenomai.org/?p=xenomai-2.5.git;a=tree;f=ksrc/drivers/serial;hb=14c921b86a82debe367c782b33273f8ba470cf6e>
/ *(*
http://git.xenomai.org/?p=xenomai-2.5.git;a=tree;f=ksrc/drivers/serial;h=9cd6f200fdf45fc2550c95431a552d647df934f4;hb=14c921b86a82debe367c782b33273f8ba470cf6e
)
<http://git.xenomai.org/?p=xenomai-2.5.git;a=tree;f=ksrc/drivers/serial;h=9cd6f200fdf45fc2550c95431a552d647df934f4;hb=14c921b86a82debe367c782b33273f8ba470cf6e>.

Take a look to the wiki too ( http://xenomai.org/index.php/16550A ).

If you tell me which architecture you are using i could help you more
(if i know it).
Bye
<http://git.xenomai.org/?p=xenomai-2.5.git;a=tree;f=ksrc/drivers/serial;h=9cd6f200fdf45fc2550c95431a552d647df934f4;hb=14c921b86a82debe367c782b33273f8ba470cf6e>

>
> Thanks a lot
>
> regards
> Peter
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


------=_20101013080811_18666
Content-Type: text/html; name="untitled-[2]"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="untitled-[2]"


------=_20101013080811_18666--



