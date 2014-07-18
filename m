Date: Fri, 18 Jul 2014 14:23:02 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
In-Reply-To: <53C8F06E.3070900@xenomai.org>
Message-ID: <freemail.20140718142302.86957.2@fmxmldata03.freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Xenomai] Memory paging trouble
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

=0A=0AGilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> =C3=ADrta:=0A=
>On 07/18/2014 11:10 AM, Paal Tamas wrote:=0A>> =0A>> =0A>> Gilles Chantepe=
rdrix <gilles.chanteperdrix@xenomai.org> =C3=ADrta:=0A>>> On 07/16/2014 02:=
42 PM, Paal Tamas wrote:=0A>>>> I keep on trying:=0A>>>>=0A>>>> Gilles,=0A>=
>>>=0A>>>> Hopefully this time it will be better.=0A>>>>=0A>>>> Besides, yo=
u can find the test app sourcecode at the end.=0A>>>>=0A>>>> I am using Xen=
o 2.6.3 together with a 3.0.15 Linux kernel on an i.MX6 ARM hardware.=0A>>>=
=0A>>> Do you have the same issue with a recent patch, like the one for 3.8=
 or=0A>>> for 3.10?=0A>>>=0A>>> -- =0A>>>                                  =
                              Gilles.=0A>> =0A>> Do you mean to patch the 3=
.015 Linux kernel using a xenomai patch for the 3.8 or 3.10 versions? No I =
did not try it.=0A>=0A>No, I mean patching Linux 3.8 or Linux 3.10 with the=
 corresponding patch.=0A>=0A>=0A>-- =0A>                                   =
                             Gilles.=0A>=0AUnfortunately the latest BSP for=
 my board (VAR-SOM-MX6) is for kernel 3.0.35. =0AIt was a nightmare to add =
xenomai support to it.  I had to start with 3.0.15 (since there was no dire=
ct Adeos and Xeno path for the 3.0.35).... I don't want to start the whole =
procedure from the beginning again...=0AIs there any other way to start wit=
h?=0A=0AThanks,=0ATamas

