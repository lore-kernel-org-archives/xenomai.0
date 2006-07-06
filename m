From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
References: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 13:35:42 +0200
Message-Id: <1152185743.4978.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RE: [Xenomai-help] Modification of the PSOS skin.
	[update]
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Antoine.BRUGEAS@fr.thalesgroup.com
Cc: Xenomai-help@domain.hid, xenomai@xenomai.org

On Wed, 2006-07-05 at 13:46 +0200, Antoine.BRUGEAS@fr.thalesgroup.com
wrote:
> Result of the diff command :
> 

Please always run the diff command with the -u option enabled to build
patches, it's a mandatory format for any code to be reviewed and later
merged. This said, I've committed the few checks for self-directed calls
your second patch adds to the trunk. Thanks.

> *************************for psos.h
> 
> 321a322
> > #define ERR_SSFN     0x03     /* Illegal system service function number */
> 325a327
> > #define ERR_OBJTFULL 0x08     /* Node's Object table full */

-- 
Philippe.



