References: <1401378135.12445.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53878C85.80506@xenomai.org>
Message-ID: <1401623803.33241.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Sun, 1 Jun 2014 12:56:43 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53878C85.80506@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rtdm_mutex_init on forge
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Philippe Gerum <rpm@xenomai.org>=
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=0A> Cc: =0A> Sent: Thursday, May 29, 2014 9:37 PM=0A> S=
ubject: Re: [Xenomai] rtdm_mutex_init on forge=0A> =0A> On 05/29/2014 05:42=
 PM, Matthias Schneider wrote:=0A> =0A>>  Hi all,=0A>> =0A>>  I have a ques=
tion about rtdm_mutex_init in forge. BUG_ON is=0A>>  triggered each time I =
create an rtdm_mutex. This seems to be=0A>>  due to a check in xnsynch_init=
, while apparently some=0A>>  implementation is still missing in rtdm_mutex=
_init():=0A>> =0A> =0A> Could you please give a try to this patch? It imple=
ments fast locking =0A> for RTDM mutexes, which should fix the issue:=0A> =
=0A> http://git.xenomai.org/xenomai-forge.git/commit/?h=3Dnext&id=3Dc007540=
93d283247695356d416608daab0979786=0A> =0A> TIA,=0A> =0A> -- =0A> Philippe.=
=0A> =0AAgain, thanks for the fix. It seems I am now possible to lock=0Aand=
 unlock an rtdm mutex without causing exceptions. However,=A0=0AI have not =
confirmed that it is=A0actually guaranteeing mutual=A0=0Aexclusivity - I su=
ppose that this was=A0already verified previously=0Aby some kind of unit te=
st.=0A=0ARegards,=0AMatthias

