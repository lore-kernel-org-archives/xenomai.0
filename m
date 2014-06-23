Date: Mon, 23 Jun 2014 13:18:23 +0200
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20140623111823.GA5715@dmia-degroote.isae.fr>
References: <20140623090857.GA4043@dmia-degroote.isae.fr>
 <53A7F1E4.2050603@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53A7F1E4.2050603@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 23/Jun - 11:22, Gilles Chanteperdrix wrote:
> On 06/23/2014 11:08 AM, Arnaud Degroote wrote:
> > Hi list,
> > 
> > I'm trying to deploy a 3.14 kernel on my BeagleBoard XM rev C but got
> > several issues. So, first question, it is supposed to be supported or am
> > I somewhere in a grey zone ?
> > 
> > Let describe more precisely the configuration and the symptom.
> > - linux-ipipe branch ipipe-3.14
> > - xenomai 2.6.3 + some patches from 2.6 branch (including
> > 	d1d00e0acd29bb5f9023494a883a7fa0def40917 
> > 	41cb1f73814d1094e0ea75ccbbd23ff01280787e
> > 	7a48019268d7e1157ebb072b88f6683425f0c7c5
> > 	f00d22eca6277e780c19a5d5ecd2ed0e23dabafe
> > 	)
> 
> It is supposed to work, could you try again with the xenomai 2.6 git?
> 

Hi Gilles,

I just tested against 2.6-git and observe the same behaviours.

Best regards,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140623/07dee95d/attachment.sig>
