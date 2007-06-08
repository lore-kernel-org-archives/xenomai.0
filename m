From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18025.37833.610273.790254@domain.hid>
Date: Fri, 8 Jun 2007 19:37:13 +0200
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC34@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC34@domain.hid>
Subject: Re: [Xenomai-core] AT91 patch duplicated code ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

BOUIN Alexandre wrote:
 > 
 > > When we released our last version of adeos-ipipe-2.6.19-arm-AT91.patch, we suggested to merge code for at91rm9200 and at91sam926x. 
 > > These 2 code are split but quite similar, so we think it could be a good idea. Are you OK for removing duplicated code ?

If I have to choose between duplicating some Linux code in I-pipe code
and have some duplication in the I-pipe patch, I choose duplication in
the I-pipe patch. If you duplicate Linux code, you will have to avoid
forgetting to update this duplicate code when Linux code evolves.

-- 


					    Gilles Chanteperdrix.

