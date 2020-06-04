From: Josh Karch <jkarch@FirstMode.com>
Subject: Re: Xenomai.org certificate expired
Date: Thu, 4 Jun 2020 17:08:32 +0000
Message-ID: <MN2PR19MB39674CDFC76BB31BF3CC1F06D5890@MN2PR19MB3967.namprd19.prod.outlook.com>
References: <MN2PR19MB3967B89DB2DD0090FD0E7237D5890@MN2PR19MB3967.namprd19.prod.outlook.com>
 <4cb3d2bb-f345-0019-51ab-74a9c5c7b1f6@xenomai.org>,
 <e3918bc2-469e-0d51-1112-6b2e171acec1@xenomai.org>
In-Reply-To: <e3918bc2-469e-0d51-1112-6b2e171acec1@xenomai.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: Thursday, June 4, 2020 9:46 AM
To: Josh Karch <jkarch@FirstMode.com>; xenomai@xenomai.org <xenomai@xenomai=
.org>
Subject: Re: Xenomai.org certificate expired

On 6/4/20 6:18 PM, Philippe Gerum via Xenomai wrote:
> On 6/4/20 5:55 PM, Josh Karch via Xenomai wrote:
>> Hi All,
>>
>> While using Buildroot to download Xeno 3.1 I found that the certificate =
had expired, which killed the build:
>> I got the following message
>> "ERROR: The certificate of =91xenomai.org=92 is not trusted." followed b=
y a failed build.  Is this a recent expiration?
>>
>
> I renewed it last year. This expiration happened in the wake of the Secti=
go
> mess on May 30. I'll fix this.
>

Fixed.

PS: Not required to access xenomai.org anymore, but you may want to upgrade
your tls client side at some point though.

--
Philippe.

Thanks Philippe! That fixes it!

Best,
Josh
