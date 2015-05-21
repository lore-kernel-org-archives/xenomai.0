Message-ID: <555DF877.8040001@xenomai.org>
Date: Thu, 21 May 2015 17:23:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <555D77F6.7030007@basystemes.fr> <555D7C73.8030905@basystemes.fr>
 <555DCA94.1070909@xenomai.org> <555DF3D3.9090600@basystemes.fr>
In-Reply-To: <555DF3D3.9090600@basystemes.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Are concurrent writes to XDDP sockets allowed ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@basystemes.fr>, xenomai@xenomai.org
Cc: =?windows-1252?Q?C=E9line?= <celine.leberre.prestataire@basystemes.fr>

On 05/21/2015 05:03 PM, Thierry Bultel wrote:
>=20
>=20
> Le 21/05/2015 14:07, Philippe Gerum a =E9crit :
>> On 05/21/2015 08:34 AM, Thierry Bultel wrote:
>>> Hi,
>>> In an application, we have one regular thread listening on an RTP
>>> device,
>>> and 2 realtime threads that concurrently write data in the XDDP socket
>>> backend.
>>> We use the POSIX skin.
>>>
>>> Sometimes, the regular thread gets its blocking read() call just
>>> return 0.
>>> That never happens with the classic "one reader, one writer" case.
>>>
>>> Also, we notice that the 'return 0' case occurrence is not the same,
>>> depending
>>> on the fact that the realtime task uses 'write' instead of 'sendto'
>>> (more occurrences with 'sendto')
>>>
>> There is no restriction with respect to concurrent sending to such
>> socket.
> Ok, thanks
>> Knowing about the Xenomai release number,
> This is 2.6.4
>> and a simple test code that
>> actually illustrates the intended usage and ideally reproduces the issue
>> would help.
> Here is the test code, based on xddp-echo.c . Unfortunalely this does
> not reproduce the issue.
> Compared to our application, we also have 3 other additional
> realtime-regular pairs communicating on 3 dedicated channels.
>=20
> What would trigger the 'read' return with zero ?

Sending zero len messages from the rt side via sendto(), which is legit
with XDDP. Using write() won't send anything.

--=20
Philippe.

