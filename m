From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
MIME-Version: 1.0
Date: Fri, 27 Aug 2021 11:29:33 +0200
Subject: Doing DMA from peripheral to userland memory
Message-ID: <10a0-6128b080-11d-29fb8780@204571863>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

working on a zynq7000 target (arm cortex a9), we have a peripheral that=
 generates loads of data (many kbytes per ms).

We would like to move that data, directly from the peripheral memory (t=
he OCM of the SoC) directly to our RT application user memory using DMA=
.

For one part of the data, we would like the DMA to de interlace that da=
ta while moving it. We figured out, the PL330 peripheral on the SoC sho=
uld be able to do it, however, we would like, as much as possible, to r=
etain the use of one or two channels of the PL330 to plain linux non RT=
 use (via dmaengine).

My first attempt would be to enhance the dmaengine API to add RT API, t=
hen implement the RT API calls in the PL330 driver.

What do you think of this approach, and is it achievable at all (DMA di=
rectly to user land memory and/or having DMA channels exploited by xeno=
mai and other by linux) ?

Thanks in advance

Fran=C3=A7ois


