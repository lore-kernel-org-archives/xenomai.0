From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.47277.107485.852148@domain.hid>
Date: Wed, 6 Aug 2003 10:13:33 +0200
Subject: Re: [Adeos-main] Adeos and RTAI memory
In-Reply-To: <20030806.AAA1060097315@domain.hid>
References: <20030806.AAA1060097315@domain.hid>
Reply-To: philippe.gerum@domain.hid
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: hwoarang@domain.hid
Cc: adeos-main@gna.org

hwoarang@domain.hid wrote:
 > Hello all.
 > 
 > I send this mail for some questions.
 > 
 > 1) While running RTAI over the Adeos, does RTAI use Linux domain's kernel memory space
 >    like other device drivers?
 > 

Yes.

 > 2) For propagating interrup or managing domains, does Adeos use some scheduling policies
 >    or just manage domains as linked list?
 > 

It manages a simple linked list of domains ordered by priority,
walking it to process the pipeline.

 > 3) The design document doesn't contain the current implementation of Adoes.
 >    Do the developers have some plans to update the document? ;)
 >    It makes me fuzzy. :@
 > 

I'm working on an Adeos porting guide which might give you some
answers. Don't expect a complete and polished reference and
implementation guide, but it should be descriptive enough to grasp the
core stuff.

 > Please answer these questions. :)
 > 
 > May the force be with you!
 > 

It is. Just can't get this bloody light-saber working though...

Philippe.


