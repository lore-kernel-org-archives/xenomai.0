Message-ID: <BLU0-SMTP919B70F18235329A81D0D5AF010@phx.gbl>
From: Chiara <chiaracapretti@hotmail.it>
Date: Mon, 21 Oct 2013 20:09:07 +0200
MIME-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] HELP with xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi everyone!

I've got a problem..I try the command xeno-test.
I put this command

sudo xeno-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -p 100 -g histo

but I obtained 

"illegal option -g"

so I substitute with -h (even if it shouldn't give the same result)

after, the command start but I obtained a list of "something died at 17272"

If I do only the command latency, everything goes ok..what can I do? 

Thanks a lot!
