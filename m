From: "Rothermel, Thomas" <Thomas.Rothermel@fkfs.de>
Date: Sat, 29 Aug 2015 16:12:19 +0000
Message-ID: <8655AC8285F53F42A4B1B3CAB3092C47235FD340@IVKEX2.fkfs.de>
References: <8655AC8285F53F42A4B1B3CAB3092C47235FC2D7@IVKEX2.fkfs.de>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD2F2@IVKEX2.fkfs.de>
 <8655AC8285F53F42A4B1B3CAB3092C47235FD31D@IVKEX2.fkfs.de>,
 <20150829154617.GF20679@hermes.click-hack.org>
In-Reply-To: <20150829154617.GF20679@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Question about priority coupling in primary and
 secondary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles, thank you very much for your fast reply. =0A=
=0A=
>> Furthermore I can't use RTnet, because all other network nodes=0A=
>> don't use it.=0A=
=0A=
>That is a wrong reason not to use RTnet.=0A=
=0A=
Ok does that mean that it is possible combining RTnet and non RTnet network=
 nodes? That would solve my problem. If the answer is yes, I couldn't figur=
e out how to configure RTnet to  send standart UDP messages. Do I have to l=
oad the rt version of my network card driver?=0A=
=0A=
=0A=
>> Then I found out that from Xenomai v2.6.x on, the option=0A=
>> XENO_OPT_PRIOCPL was disabled by default, and I recompiled the=0A=
>> kernel with XENO_OPT_PRIOCPL enabled. Unfortunately that didn't=0A=
>> help. As far as I understand, this option should solve my=0A=
>> problem...=0A=
=0A=
>The root thread priority coupling does not solve everything. In=0A=
>particular, when a thread is suspended waiting for an interrupt, the=0A=
>primary mode activity has priority over handling the non real-time=0A=
>interrupt.=0A=
=0A=
Ok, thanks that' s  the explanation why it is not working...=0A=
=0A=
Best, Thomas=0A=
=0A=
>--=0A=
                                            Gilles.=0A=
>https://click-hack.org=0A=

