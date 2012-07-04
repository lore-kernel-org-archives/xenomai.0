Message-ID: <4FF42271.20602@xenomai.org>
Date: Wed, 04 Jul 2012 13:01:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>	<4FEC3FF0.1050307@grandegger.com>,
	<4FEC4245.9090804@grandegger.com>	<D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>	<4FEC46B5.7060700@grandegger.com>
	<4FEC5381.9040804@epfl.ch>	<4FEC570A.8040406@grandegger.com>
	<4FEC5BD9.4060105@grandegger.com> <4FEC819D.2080804@epfl.ch>
	<4FEC8259.2090300@xenomai.org> <4FEC8A85.4050506@epfl.ch>,
	<4FEC8AFB.5070002@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162E0C5@REXMF.intranet.epfl.ch>
In-Reply-To: <D1DC5191D5CF3A45A867CD95644B92392162E0C5@REXMF.intranet.epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kronander Klas <klas.kronander@epfl.ch>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/04/2012 12:59 PM, Kronander Klas wrote:
> If run the xenomai ./configure script without any arguments and then
> build and install, I get the following message when running
> ./usr/xenomai/bin/clocktest:

Have you tried to run ./configure CFLAGS="-fno-omit-frame-pointer" as I
already suggested?

-- 
                                                                Gilles.

