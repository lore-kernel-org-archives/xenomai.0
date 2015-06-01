Date: Mon, 1 Jun 2015 23:21:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150601212154.GK27570@hermes.click-hack.org>
References: <5349076.XOSFdPdBY7@indiana>
 <20150601101706.GB25476@hermes.click-hack.org>
 <1532737.3vFK565vsb@indiana>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1532737.3vFK565vsb@indiana>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gpg signatures of releases
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Jun 01, 2015 at 10:52:27PM +0200, Leopold Palomo-Avellaneda wrote:
> El Dilluns, 1 de juny de 2015, a les 12:17:06, Gilles Chanteperdrix va 
> escriure:
> > On Mon, Jun 01, 2015 at 12:11:03AM +0200, Leopold Palomo-Avellaneda wrote:
> > > Hi,
> > > 
> > > who sig
> > > 
> > > http://download.gna.org/xenomai/stable/latest/*.sig
> > > 
> > > ?
> > 
> > I do. There used to be a readme file that said so, but it seems it
> > is no longer displayed by gna. In any case, if you go to the gna
> > interface you should find the keys of all the project members,
> > including mine (in fact, gna quarantines an upload if it is not
> > signed by a project member, or at least is used to). I use the same
> > key to sign that mail.
> 
> When I try to download the keyring I get a 0 bytes long file from here:
> 
> http://gna.org/project/memberlist-gpgkeys.php?group=xenomai
> 
> I found that the file was signed by this key with this id A9BF7DBA,
> but I have not found who is the proprietary.
> 
> gpg: using character set `utf-8'
> :signature packet: algo 17, keyid 1A972013A9BF7DBA
> 	version 3, created 1411642226, md5len 5, sigclass 0x00
> 	digest algo 2, begin of digest 95 30
> 	data: [158 bits]
> 	data: [158 bits]
> gpg: Nombre total processat: 0
> 
> Any idea?

1- as I told you the key was mine, you can download the key from my
account:
http://gna.org/users/gch

2- have you tried gpg --recv-keys ?

I believe this key expired though, my new key is 7F392711, but of
course the xenomai archives are not signed with it yet.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150601/69a2f56e/attachment.sig>
