Message-ID: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
Date: Fri, 21 Feb 2014 06:31:15 -0800 (PST)
From: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] User Space Problems
Reply-To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AI'm using a Sabre Lite board with IMX6Q for a project. =0AI =0Ains=
talled xenomai with the kernel 3.0.35 from boundary Devices, its not =0Athe=
 version indicated in README file, but I applied the patches and it =0Aseem=
s work. When it boots can see the messages:=0A=0AI-pipe: Domain Xenomai reg=
istered.=0AXenomai: hal/arm started.=0AXenomai: scheduling class idle regis=
tered.=0AXenomai: scheduling class rt registered.=0AXenomai: real-time nucl=
eus v2.6.3 (Lies and Truths) loaded.=0AXenomai: debug mode enabled.=0AXenom=
ai: starting native API services.=0AXenomai: starting POSIX services.=0AXen=
omai: starting RTDM services.=0A=0ABut the user space is not working. When =
I try to execute latency and xeno-test commands I get a error message: not=
=0A found.=0A=0Alinaro@linaro-alip:/usr/xenomai/bin$ ./latency=0Abash: ./la=
tency: No such file or directory=0Alinaro@linaro-alip:/usr/xenomai/bin$ ./x=
eno-test=0Abash: ./xeno-test: /usr/xenomai/bin/xeno-test-run: bad interpret=
er: No such file or directory=0Alinaro@linaro-alip:/usr/xenomai/bin$ sudo .=
/xeno latency=0A./xeno: 15: exec: /usr/xenomai/bin/latency: not found=0A=0A=
The only command that work is xeno-config. I started using Linux for this p=
roject so I don't know how to solve it.=0A=0AI=0A tried to search some solu=
tion on mailing list, but anything yet. In =0Atroubleshooting guide I read =
about EABI and OABI compilers mismatch, but=0A I compiled both kernel and u=
ser space with Linaro toolchain =0A(arm-linux-gnueabi). I tried with Ubuntu=
 cross-compiler too =0A(arm-linux-gnueabihf), but same result.=0A=0AThanks,=
=0ABruno
