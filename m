MIME-Version: 1.0
Date: Thu, 29 Jan 2015 09:46:13 +0100
Message-ID: <CAHH_qdB0SL01DFidmSQ96YSOoGxpuNLTWoO87K-q6mEA-fM-Rg@mail.gmail.com>
From: Gautier HAOUY <gautier.haouy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] imx28 linux 3.10.32 + ipipe v7 + GPIO IRQ machine freeze
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

I am kindly requesting your help today as I am facing a complete freeze on
an Freescale iMX28 based board (armadeus APF28-Dev).
I have developed a very simple kernel module which registers a GPIO
interrupt handler, working properly on linux 3.10.32 kernel.
The same code, compiled on a 3.10.32 + ipipe7 (also tested on ipipe v4)
patched kernel generates a machine freeze on IRQ reception, without message
and any other possibility than resetting the board.

I would appreciate any help/hint/procedure I could use to dive into the
problem and solve it.
Hoping to help others afterwards,
Best regards,
G0TieR.
