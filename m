MIME-Version: 1.0
Date: Sun, 14 Nov 2010 11:27:25 +0000
Message-ID: <AANLkTingEZJdsJDb6nuOc3TmAfpyHSE6FXT5WE=L_GV-@domain.hid>
From: Andreas Glatz <andi.glatz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> Now my question is: how do I investigate an issue like this? In other words,
> which are the best tools since this code involves both user and kernel space
> debugging.
> Are there some trace tools available that are able to generate a kind of
> sequence / trace of what is happing over time.
>
> I also have other issues that are not consistently reproducible. For this
> kind of problems trace tools would also be useful.
>

I have debugged such issues with LTTng ( http://lttng.org/ ). There
are trace points in the Xenomai nucleus ( grep -rw xn_nucleus
/path/to/xenomai/* ) and skins (at least the native skin). You could
for example set up 'one-shot' tracing where events are continuously
added to the Lttng event ring buffer until a condition is satisfied
(i.e. your error condition) and analyse it either with Lttv or by
looking at the textual output.

It takes some time to set things up. You need (1) to add the LTTng
patches to your kernel and recompile the whole thing. In general,
there are just LTTng patches for vanilla kernels available. So you
have to expect some manual work there. (2) You have to compile the
user-space daemon for your target: You need it to control the tracing.
(3) Lttv for your host (if you like a little bit of comfort when
analysing your traces).

Andreas

