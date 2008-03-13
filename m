Message-ID: <d6c8ef150803130719p63589e3ap292ceeabaf1ef59a@domain.hid>
Date: Thu, 13 Mar 2008 15:19:41 +0100
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <2ff1a98a0803130648x6693b38cp51402c8831dc72b4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
	<d6c8ef150803130409g2a618d30gbede878d6a09e470@domain.hid>
	<2ff1a98a0803130412h12261b67n3b43912354173107@domain.hid>
	<d6c8ef150803130423p63a0a43esb37b74efcf009476@domain.hid>
	<2ff1a98a0803130606u7d6dd7b3mce33a5e30735d11a@domain.hid>
	<d6c8ef150803130610q5677912ft60865a912ed6fe00@domain.hid>
	<2ff1a98a0803130621j58f7f320l4cbf44467732bc5b@domain.hid>
	<d6c8ef150803130636h7f064e2cof5d82676f1e19af@domain.hid>
	<2ff1a98a0803130648x6693b38cp51402c8831dc72b4@domain.hid>
Subject: Re: [Adeos-main] New I-pipe patch for ARM.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

On Thu, Mar 13, 2008 at 2:48 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

>  The TC frequency is master clock / 32, which is around 32 MHz, but if
>  the wrap time is less than 20 ms, it is too short. To see if it is
>  really the problem, you should launch latency -p 1000, and see if the
>  network works. If it works, then the problem is TC wrap time.

Well, no "improvements" during latency -p 1000 execution. I still get
"transmit timed out" and I can see on the Ethernet side arp who-has
requests from the target board.

