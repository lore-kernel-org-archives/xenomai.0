Date: Fri, 23 Nov 2018 13:27:16 +0100
From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: Testing of 4.4/Ipipe + Xenomai 3.0.X on ARM32
Message-ID: <20181123122716.tgg3utytwyrkzyid@jholzmayr.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello!

To improve the testing situation for the 4.4 Kernel family on ARM32, I
created a set of layers [1] for OpenEmbedded. Currently the features are
rather limited:

- only the Morty branch exists, as this one natively includes Linux 4.4
  and therefore the GCC version etc. matches.
- only one BSP layer so far, namely the Beaglebone. This was chosen for
  two major reasons: a) it is supported well enough in 4.4. to not need
  additional patches which might introduce new issues, and b) it is
  hardware that I have here ready for testing.
- no higher automation like a kas cofiguration so far. Yet this probably
  will be the first limitation to be gotten rid of.

My current planning is to add a set of testing scripts based of
Philippe's suggestion, and run that suite on each new release for a
couple of days and post the results to the ML.

Preliminary results to kick off things:
- xeno-test completes successfully
- latency -t0 under load maxes at ~58µs
- latency -t2 under load maxes at ~18µs

Greetz

[1] https://github.com/LetoThe2nd/meta-xenomai
-- 
———————————————
Josef Holzmayr
Software Developer Embedded Systems

Tel: +49 8444 9204-48
Fax: +49 8444 9204-50

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de
———————————————
Amtsgericht Ingolstadt – GmbH: HRB 191328 – KG: HRA 170393
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
Ust-IdNr: DE 128592548 

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


