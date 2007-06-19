Message-ID: <f48df4840706191211h232fefe0tb14ff96372117c5a@domain.hid>
Date: Tue, 19 Jun 2007 21:11:48 +0200
From: "Bruno Rouchouse" <brouchouse@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_97380_308009.1182280308913"
Subject: [Xenomai-help] Adeos tag on kernel name
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

------=_Part_97380_308009.1182280308913
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Xenomai users !

just having some little trouble with my last Xenomai compilation. I'm
wondering what I'm doing wrong...

Last kernel I build on my laptop was a 2.6.20.11. uname -a gives me:
2.6.20.11-adeos #1 SMP Thu May 17...

Modules are installed in a directory named /lib/modules/2.6.20.11-adeos

So far everything is fine...

On my workstation with a freshly installed Debian etch distribution, uname
-a returns:
2.6.20.11-adeos #1 SMP Thu May 17...

No adeos tag here!

During the build and installation process of the kernel, my
/lib/modules/2.6.20.14 (without adeos this one) has been then overwritten --
no big deal though -- but I would like to have both version of 2.6.20.14 on
my box:  one with adeos and another without it.

Did I forget anything somewhere? Configuration maybe...

I tried to find out what condition changes the name of the built kernel --
Makefile (EXTRAVERSION) or include/linux/version.h -- but I haven't been too
lucky so far.

Could someone point me out what is wrong here or what I'm doing wrong?

Thanks in advance.

--Bruno

------=_Part_97380_308009.1182280308913
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Xenomai users !<br><br>just having some little trouble with my last Xenomai compilation. I&#39;m wondering what I&#39;m doing wrong...<br><br>Last kernel I build on my laptop was a <a href="http://2.6.20.11">2.6.20.11</a>
. uname -a gives me:<br>2.6.20.11-adeos #1 SMP Thu May 17...<br><br>Modules are installed in a directory named /lib/modules/2.6.20.11-adeos <br>
<br>So far everything is fine...<br><br>On my workstation with a freshly installed Debian etch distribution, uname -a returns:<br>2.6.20.11-adeos #1 SMP Thu May 17...
<br><br>No adeos tag here!<br><br>During the build and installation process of the kernel, my /lib/modules/2.6.20.14 (without adeos this one) has been then overwritten -- no big deal though -- but I would like to have both version of 
<a href="http://2.6.20.14">2.6.20.14</a> on my box:&nbsp; one with adeos and another without it.<br><br>Did I forget anything somewhere? Configuration maybe...<br><br>I tried to find out what condition changes the name of the built kernel -- Makefile (EXTRAVERSION) or include/linux/version.h -- but I haven&#39;t been too lucky so far.
<br><br>Could someone point me out what is wrong here or what I&#39;m doing wrong?<br><br>Thanks in advance.<br><br>--Bruno<br><br>

------=_Part_97380_308009.1182280308913--

