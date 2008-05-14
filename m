Message-ID: <482ADDD1.4070507@domain.hid>
Date: Wed, 14 May 2008 14:40:49 +0200
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
References: <48299843.7090307@domain.hid>	
	<2ff1a98a0805130731o5a78e490s77131ee48ee3b741@domain.hid>	
	<482A9E3E.7040608@domain.hid>
	<2ff1a98a0805140157q65ed8014k6725fc7f0b3a8f64@domain.hid>
In-Reply-To: <2ff1a98a0805140157q65ed8014k6725fc7f0b3a8f64@domain.hid>
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] v2.4.3 bug with system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Gilles Chanteperdrix a &eacute;crit&nbsp;:
<blockquote
 cite="mid:2ff1a98a0805140157q65ed8014k6725fc7f0b3a8f64@domain.hid"
 type="cite">
  <pre wrap="">On Wed, May 14, 2008 at 10:09 AM, St&eacute;phane ANCELOT <a class="moz-txt-link-rfc2396E" href="mailto:sancelot@domain.hid">&lt;sancelot@domain.hid&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> Gilles Chanteperdrix a &eacute;crit :

 On Tue, May 13, 2008 at 3:31 PM, St&eacute;phane ANCELOT <a class="moz-txt-link-rfc2396E" href="mailto:sancelot@domain.hid">&lt;sancelot@domain.hid&gt;</a> wrote:


 Hi,
 Using the v2.4.3 +kernel 2.6.24.7 I used the system("touch /tmp/xxx_ok")
 call in a non realtime init context.

 The task is only used to allocate some memory heaps.

 I setted up some memory debugging features in the kernel :
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_SLAB_LEAK=y
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_VM=y
 CONFIG_FORCED_INLINING=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_PAGEALLOC=y

 This was not happening with v2.4.2 although that the kernel debugging
 flags were not "on"

 It would be nice if you could try the v2.4.2 with debugging options
on, to know if it is a regression or not.


 No time left, going back on v2.4.2. However, I have exactly the same
problem, if I use the fork() call inside a program.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Have you tried Jan fix ?

  </pre>
</blockquote>
No, but I tried the same fork call with a vanilla kernel with debugging
options : THE PROBLEM IS THE SAME , so I suppose it is not depending on
xenomai, I forward the problem to LKML<br>
<br>
</body>
</html>

