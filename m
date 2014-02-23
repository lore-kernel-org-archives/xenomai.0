References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
Message-ID: <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
Date: Sun, 23 Feb 2014 15:32:28 -0800 (PST)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
In-Reply-To: <530766CD.3060707@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] User Space Problems
Reply-To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,=0A=0AThe problem was the second statement: the toolchain I was u=
sing is diferente from the used on root filesystem. My filesystem is a rece=
nt version from Linaro, but I was using an old Linaro toolchain version (4.=
7, I think), then I changed to the new version (4.8) and I can run now Xeno=
mai commands. Thanks.=0AI had to recompile the kernel too because I didn't =
disable CONFIG_CPU_FREQ and CONFIG_CPU_FREQ_IMX (I got unexpected values).=
=0A=0AI have only one more question. I executed the latency command and, in=
itially, I was getting latencies with negative numbers. But executing the c=
ommand some times, it appear ok. Below a result with no load.=0Alinaro@lina=
ro-alip:/usr/xenomai/bin$ sudo ./latency =0A=3D=3D Sampling period: 1000 us=
=0A=3D=3D Test mode: periodic user-mode task=0A=3D=3D All results in micros=
econds=0Awarming up...=0ARTT|=A0 00:00:01=A0 (periodic user-mode task, 1000=
 us period, priority 99)=0ARTH|----lat min|----lat avg|----lat max|-overrun=
|---msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 1.255|=A0=A0=A0=A0=A0=
 1.383|=A0=A0=A0=A0=A0 4.184|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.255|=A0=A0=A0=A0=A0 4.184=0ARTD|=A0=A0=A0=A0=A0 1.265|=A0=A0=A0=A0=
=A0 1.656|=A0=A0=A0=A0 13.080|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.255|=A0=A0=A0=A0 13.080=0ARTD|=A0=A0=A0=A0=A0 1.260|=A0=A0=A0=A0=
=A0 1.502|=A0=A0=A0=A0 17.409|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.255|=A0=A0=A0=A0 17.409=0ARTD|=A0=A0=A0=A0=A0 1.267|=A0=A0=A0=A0=
=A0 1.499|=A0=A0=A0=A0 14.593|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.255|=A0=A0=A0=A0 17.409=0ARTD|=A0=A0=A0=A0=A0 1.260|=A0=A0=A0=A0=
=A0 1.525|=A0=A0=A0=A0 12.126|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.255|=A0=A0=A0=A0 17.409=0ARTD|=A0=A0=A0=A0=A0 1.249|=A0=A0=A0=A0=
=A0 1.709|=A0=A0=A0=A0 12.853|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.249|=A0=A0=A0=A0 17.409=0ARTD|=A0=A0=A0=A0=A0 1.260|=A0=A0=A0=A0=
=A0 1.512|=A0=A0=A0=A0 18.265|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.249|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.257|=A0=A0=A0=A0=
=A0 1.522|=A0=A0=A0=A0 17.191|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.249|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.260|=A0=A0=A0=A0=
=A0 1.492|=A0=A0=A0=A0 14.492|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.249|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.257|=A0=A0=A0=A0=
=A0 1.671|=A0=A0=A0=A0 13.712|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.249|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.244|=A0=A0=A0=A0=
=A0 1.510|=A0=A0=A0=A0 14.555|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.244|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.239|=A0=A0=A0=A0=
=A0 1.484|=A0=A0=A0=A0 13.525|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.272|=A0=A0=A0=A0=
=A0 1.532|=A0=A0=A0=A0 17.608|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.262|=A0=A0=A0=A0=
=A0 1.661|=A0=A0=A0=A0 13.472|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.270|=A0=A0=A0=A0=
=A0 1.487|=A0=A0=A0=A0 16.542|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.267|=A0=A0=A0=A0=
=A0 1.717|=A0=A0=A0=A0 15.383|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.249|=A0=A0=A0=A0=
=A0 1.507|=A0=A0=A0=A0 16.411|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.242|=A0=A0=A0=A0=
=A0 1.661|=A0=A0=A0=A0 17.873|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.239|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.234|=A0=A0=A0=A0=
=A0 1.494|=A0=A0=A0=A0 12.537|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.234|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.277|=A0=A0=A0=A0=
=A0 1.699|=A0=A0=A0=A0 13.628|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.234|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.262|=A0=A0=A0=A0=
=A0 1.502|=A0=A0=A0=A0 16.914|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 1.234|=A0=A0=A0=A0 18.265=0ARTT|=A0 00:00:22=A0 (periodic user-mode =
task, 1000 us period, priority 99)=0ARTH|----lat min|----lat avg|----lat ma=
x|-overrun|---msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 1.262|=A0=
=A0=A0=A0=A0 1.661|=A0=A0=A0=A0 12.856|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.234|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.270|=A0=
=A0=A0=A0=A0 1.510|=A0=A0=A0=A0 12.661|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.234|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.270|=A0=
=A0=A0=A0=A0 1.492|=A0=A0=A0=A0 17.161|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.234|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.227|=A0=
=A0=A0=A0=A0 1.499|=A0=A0=A0=A0 15.984|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.280|=A0=
=A0=A0=A0=A0 1.712|=A0=A0=A0=A0 15.186|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.249|=A0=
=A0=A0=A0=A0 1.515|=A0=A0=A0=A0 16.888|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.255|=A0=
=A0=A0=A0=A0 1.593|=A0=A0=A0=A0 13.333|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.267|=A0=
=A0=A0=A0=A0 1.489|=A0=A0=A0=A0 16.810|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.252|=A0=
=A0=A0=A0=A0 1.664|=A0=A0=A0=A0 13.318|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.267|=A0=
=A0=A0=A0=A0 1.479|=A0=A0=A0=A0 11.202|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.249|=A0=
=A0=A0=A0=A0 1.497|=A0=A0=A0=A0 12.868|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0ARTD|=A0=A0=A0=A0=A0 1.265|=A0=
=A0=A0=A0=A0 1.517|=A0=A0=A0=A0 16.853|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=
=A0=A0=A0=A0=A0 1.227|=A0=A0=A0=A0 18.265=0A^C---|-----------|-----------|-=
----------|--------|------|-------------------------=0ARTS|=A0=A0=A0=A0=A0 =
1.227|=A0=A0=A0=A0=A0 1.555|=A0=A0=A0=A0 18.265|=A0=A0=A0=A0=A0=A0 0|=A0=A0=
=A0=A0 0|=A0=A0=A0 00:00:34/00:00:34=0A=0AI was getting large values too (l=
at avg, lat max), sometimes more than 2000 us. But with a 'top' command I v=
erified that there were processes using more than 80% of CPU, so I think it=
's the cause of these values. I executed a xeno-test command and I got the =
partial result below.=0AStarted child 11510: dohell 900=0AStarted child 115=
12: /usr/xenomai/bin/latency=0A=3D=3D Sampling period: 1000 us=0A=3D=3D Tes=
t mode: periodic user-mode task=0A=3D=3D All results in microseconds=0Awarm=
ing up...=0ARTT|=A0 00:00:01=A0 (periodic user-mode task, 1000 us period, p=
riority 99)=0ARTH|----lat min|----lat avg|----lat max|-overrun|---msw|---la=
t best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 4.530|=A0=A0=A0=A0 10.681|=A0=A0=
=A0=A0 20.570|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.530|=A0=
=A0=A0=A0 20.570=0ARTD|=A0=A0=A0=A0=A0 4.588|=A0=A0=A0=A0 11.494|=A0=A0=A0 =
309.452|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.530|=A0=A0=A0=
 309.452=0ARTD|=A0=A0=A0=A0=A0 4.580|=A0=A0=A0=A0 10.944|=A0=A0=A0=A0 37.65=
6|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.530|=A0=A0=A0 309.4=
52=0ARTD|=A0=A0=A0=A0=A0 4.489|=A0=A0=A0=A0 11.696|=A0=A0=A0 492.573|=A0=A0=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.489|=A0=A0=A0 492.573=0ARTD=
|=A0=A0=A0=A0=A0 4.489|=A0=A0=A0=A0 11.303|=A0=A0=A0 460.818|=A0=A0=A0=A0=
=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.489|=A0=A0=A0 492.573=0ARTD|=A0=
=A0=A0=A0=A0 4.085|=A0=A0=A0=A0 11.704|=A0=A0=A0 133.328|=A0=A0=A0=A0=A0=A0=
 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.085|=A0=A0=A0 492.573=0ARTD|=A0=A0=A0=
=A0=A0 8.707|=A0=A0=A0=A0 13.636|=A0=A0=A0 656.525|=A0=A0=A0=A0=A0=A0 0|=A0=
=A0=A0=A0 0|=A0=A0=A0=A0=A0 4.085|=A0=A0=A0 656.525=0ARTD|=A0=A0=A0=A0=A0 4=
.967|=A0=A0=A0=A0 13.671|=A0=A0=A0 664.366|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 4.085|=A0=A0=A0 664.366=0ARTD|=A0=A0=A0=A0=A0 6.108|=
=A0=A0=A0=A0 12.156|=A0=A0=A0=A0 50.393|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0=
|=A0=A0=A0=A0=A0 4.085|=A0=A0=A0 664.366=0ARTD|=A0=A0=A0=A0=A0 3.957|=A0=A0=
=A0=A0 12.883|=A0=A0=A0 384.060|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=
=A0=A0=A0 3.957|=A0=A0=A0 664.366=0ARTD|=A0=A0=A0=A0=A0 4.022|=A0=A0=A0=A0 =
12.578|=A0=A0=A0 962.146|=A0=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0=
=A0 3.957|=A0=A0=A0 962.146=0ARTD|=A0=A0=A0=A0=A0 3.982|=A0=A0=A0=A0 12.565=
|=A0=A0 1080.361|=A0=A0=A0=A0=A0=A0 1|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.957|=
=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 4.507|=A0=A0=A0=A0 10.906|=A0=A0=A0 4=
52.252|=A0=A0=A0=A0=A0=A0 1|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.957|=A0=A0 108=
0.361=0ARTD|=A0=A0=A0=A0=A0 4.845|=A0=A0=A0=A0 11.047|=A0=A0=A0 112.396|=A0=
=A0=A0=A0=A0=A0 1|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.957|=A0=A0 1080.361=0ART=
D|=A0=A0=A0=A0=A0 4.803|=A0=A0=A0=A0 10.782|=A0=A0=A0=A0 55.315|=A0=A0=A0=
=A0=A0=A0 1|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.957|=A0=A0 1080.361=0ARTD|=A0=
=A0=A0=A0=A0 3.906|=A0=A0=A0=A0 10.464|=A0=A0 1043.691|=A0=A0=A0=A0=A0=A0 2=
|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.906|=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0=
 3.959|=A0=A0=A0=A0=A0 8.335|=A0=A0=A0=A0 46.666|=A0=A0=A0=A0=A0=A0 2|=A0=
=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.906|=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 4.0=
42|=A0=A0=A0=A0 10.772|=A0=A0=A0=A0 45.176|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=
=A0 0|=A0=A0=A0=A0=A0 3.906|=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 3.999|=A0=
=A0=A0=A0 11.555|=A0=A0=A0 696.714|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=
=A0=A0=A0=A0 3.906|=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 4.010|=A0=A0=A0=A0=
 10.982|=A0=A0=A0=A0 35.601|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=
=A0=A0 3.906|=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 3.972|=A0=A0=A0=A0 11.55=
0|=A0=A0=A0=A0 42.679|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3=
.906|=A0=A0 1080.361=0ARTT|=A0 00:00:22=A0 (periodic user-mode task, 1000 u=
s period, priority 99)=0ARTH|----lat min|----lat avg|----lat max|-overrun|-=
--msw|---lat best|--lat worst=0ARTD|=A0=A0=A0=A0=A0 4.303|=A0=A0=A0=A0 12.7=
60|=A0=A0=A0=A0 43.477|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 =
3.906|=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 3.636|=A0=A0=A0=A0 10.439|=A0=
=A0=A0 208.924|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=
=A0=A0 1080.361=0ARTD|=A0=A0=A0=A0=A0 3.681|=A0=A0=A0=A0 13.588|=A0=A0=A0 8=
20.573|=A0=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 108=
0.361=0ARTD|=A0=A0=A0=A0=A0 4.065|=A0=A0=A0=A0 14.502|=A0=A0=A0 885.888|=A0=
=A0=A0=A0=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1080.361=0ART=
D|=A0=A0=A0=A0=A0 3.987|=A0=A0=A0=A0 14.954|=A0=A0=A0 989.131|=A0=A0=A0=A0=
=A0=A0 2|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1080.361=0ARTD|=A0=A0=
=A0=A0=A0 3.926|=A0=A0=A0=A0 14.542|=A0=A0 1383.499|=A0=A0=A0=A0=A0=A0 3|=
=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 =
3.853|=A0=A0=A0=A0 14.560|=A0=A0 1154.987|=A0=A0=A0=A0=A0=A0 4|=A0=A0=A0=A0=
 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 4.659|=A0=A0=
=A0=A0 13.555|=A0=A0=A0 924.207|=A0=A0=A0=A0=A0=A0 4|=A0=A0=A0=A0 0|=A0=A0=
=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 3.893|=A0=A0=A0=A0 13=
.777|=A0=A0=A0 663.159|=A0=A0=A0=A0=A0=A0 4|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 =
3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 4.426|=A0=A0=A0=A0 13.454|=A0=
=A0=A0 808.964|=A0=A0=A0=A0=A0=A0 4|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=
=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 4.744|=A0=A0=A0=A0 14.840|=A0=A0=A0 8=
27.146|=A0=A0=A0=A0=A0=A0 4|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 138=
3.499=0ARTD|=A0=A0=A0=A0=A0 4.386|=A0=A0=A0=A0 12.659|=A0=A0=A0 572.785|=A0=
=A0=A0=A0=A0=A0 4|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1383.499=0ART=
D|=A0=A0=A0=A0=A0 3.999|=A0=A0=A0=A0 15.138|=A0=A0 1152.191|=A0=A0=A0=A0=A0=
=A0 5|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=
=A0=A0 3.954|=A0=A0=A0=A0 14.227|=A0=A0=A0 993.108|=A0=A0=A0=A0=A0=A0 5|=A0=
=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 4.4=
89|=A0=A0=A0=A0 12.805|=A0=A0=A0 666.755|=A0=A0=A0=A0=A0=A0 5|=A0=A0=A0=A0 =
0|=A0=A0=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 3.921|=A0=A0=
=A0=A0 12.608|=A0=A0=A0 703.176|=A0=A0=A0=A0=A0=A0 5|=A0=A0=A0=A0 0|=A0=A0=
=A0=A0=A0 3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 4.022|=A0=A0=A0=A0 12=
.424|=A0=A0=A0 574.785|=A0=A0=A0=A0=A0=A0 5|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 =
3.636|=A0=A0 1383.499=0ARTD|=A0=A0=A0=A0=A0 4.553|=A0=A0=A0=A0 12.891|=A0=
=A0=A0 717.265|=A0=A0=A0=A0=A0=A0 5|=A0=A0=A0=A0 0|=A0=A0=A0=A0=A0 3.636|=
=A0=A0 1383.499=0A^C---|-----------|-----------|-----------|--------|------=
|-------------------------=0ARTS|=A0=A0=A0=A0=A0 3.636|=A0=A0=A0=A0 12.446|=
=A0=A0 1383.499|=A0=A0=A0=A0=A0=A0 5|=A0=A0=A0=A0 0|=A0=A0=A0 00:00:39/00:0=
0:39=0A=0ACould you say if these results are right or not.=0A=0AThank you f=
or the reply,=0A=0ABruno=0A=0A=0A=0A=0A=0AEm Sexta-feira, 21 de Fevereiro d=
e 2014 11:46, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> escre=
veu:=0A =0AOn 02/21/2014 03:31 PM, Bruno Tunes de Mello wrote:=0A=0A> Hi,=
=0A>=0A> I'm using a Sabre Lite board with IMX6Q for a project.=0A> I=0A> i=
nstalled xenomai with the kernel 3.0.35 from boundary Devices, its not=0A> =
the version indicated in README file, but I applied the patches and it=0A> =
seems work. When it boots can see the messages:=0A>=0A> I-pipe: Domain Xeno=
mai registered.=0A> Xenomai: hal/arm started.=0A> Xenomai: scheduling class=
 idle registered.=0A> Xenomai: scheduling class rt registered.=0A> Xenomai:=
 real-time nucleus v2.6.3 (Lies and Truths) loaded.=0A> Xenomai: debug mode=
 enabled.=0A> Xenomai: starting native API services.=0A> Xenomai: starting =
POSIX services.=0A> Xenomai: starting RTDM services.=0A>=0A> But the user s=
pace is not working. When I try to execute latency and xeno-test commands I=
 get a error message: not=0A>=A0  found.=0A>=0A> linaro@linaro-alip:/usr/xe=
nomai/bin$ ./latency=0A> bash: ./latency: No such file or directory=0A> lin=
aro@linaro-alip:/usr/xenomai/bin$ ./xeno-test=0A> bash: ./xeno-test: /usr/x=
enomai/bin/xeno-test-run: bad interpreter: No such file or directory=0A> li=
naro@linaro-alip:/usr/xenomai/bin$ sudo ./xeno latency=0A> ./xeno: 15: exec=
: /usr/xenomai/bin/latency: not found=0A>=0A> The only command that work is=
 xeno-config. I started using Linux for this project so I don't know how to=
 solve it.=0A>=0A> I=0A>=A0  tried to search some solution on mailing list,=
 but anything yet. In=0A> troubleshooting guide I read about EABI and OABI =
compilers mismatch, but=0A>=A0  I compiled both kernel and user space with =
Linaro toolchain=0A> (arm-linux-gnueabi). I tried with Ubuntu cross-compile=
r too=0A> (arm-linux-gnueabihf), but same result.=0A=0AXenomai user-space s=
upport is probably mis-compiled:=0A- either you did not compile it for ARM;=
=0A- or you compile it with a toolchain which is not the same as the one =
=0Aused to generate the rest of the root filesystem.=0A=0A=0A-- =0A=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 Gilles.
