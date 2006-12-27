Message-ID: <ac3922a00612270713s72565d93j9bc566eed3c9632@domain.hid>
Date: Wed, 27 Dec 2006 16:13:30 +0100
From: "Syed Amer Gilani" <amg@domain.hid>
Sender: groove.c@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] adeos & protection rings on ppc
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

I am currently writing my Thesis about a Motor control running Linux
with Xenomai. In the Process of explaining Adeos i run into something
i don't understand. On an x86 CPU adeos runs on Ring 0 and pushes
Linux to Ring 1 to ensure it alone has access to certain things. User
Programs still run on Ring 3 as before. But the Hardware i use is
PowerPC based(mpc5200) and as far as i know on RISC Architectures
there are only 2 Protection domains, "system" and "user". How does
Adeos work here? Does it run together with Linux on the system domain
or does it push Linux in the user domain?
I hope someone can give me a short answer because documentation beside
the source code itself for the adeos ppc patch doesn't seem to exist.

Amer

