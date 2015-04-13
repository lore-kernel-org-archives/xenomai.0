Date: Mon, 13 Apr 2015 15:02:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150413130206.GB14791@hermes.click-hack.org>
References: <9BA84827B30CBE4996725F98F7DC912342962CC5@SMExchange01.siebmeyer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962CC5@SMExchange01.siebmeyer.org>
Subject: Re: [Xenomai] Xeno3.0 latency no /dev/rtheap under 3.18 i.mx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?SMOkbmVsLUJhYXMs?= Alexander <alexander.haenel-baas@sieb-meyer.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Apr 13, 2015 at 12:52:39PM +0000, Hänel-Baas, Alexander wrote:
> Ok, but in the documentation about Installing Xeno3.x
> under testing the installation is written :
> 
> "Testing the real-time system
> First run latency test"
> 
> (https://xenomai.org/installing-xenomai-3-x/)
> 
> Is there another test in Xeno3.x ?

No, the latency test exists. But you are not running it, you are
running Xenomai 2.6 one (the error /dev/rtheap is missing does not
exist with xenomai 3).

-- 
					    Gilles.

