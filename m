Subject: Re: Directory /proc/xenomai/registry/rtipc/xddp does not exist
References: <LEXPR01MB0701827C1E997DC3541284B58FCF0@LEXPR01MB0701.DEUPRD01.PROD.OUTLOOK.DE>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <4426b307-184f-0422-afe8-2d9d41625608@web.de>
Date: Fri, 27 Mar 2020 10:07:25 +0100
MIME-Version: 1.0
In-Reply-To: <LEXPR01MB0701827C1E997DC3541284B58FCF0@LEXPR01MB0701.DEUPRD01.PROD.OUTLOOK.DE>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jona Ostermann <Jona.Ostermann@janztec.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 26.03.20 11:12, Jona Ostermann via Xenomai wrote:
> Hello,
>
> one of our customers hast he problem that he needs a registry link in th=
e directory /proc/xenomai/registry/rtipc/xddp.
> But the directory does not exist, only /proc/xenomai/registry/ exists.
>
> What could be the problem?
> Is a special kernel configuration required or does a special kernel modu=
le need to be loaded?
>

The links show up once xddp is being used. You can check that via
smokey's xddp test.

If that is not the case, compare configuration and versions of the
reference xenomai-images against your setup and share your findings.

Jan

