Message-ID: <50E959EC.8030306@web.de>
Date: Sun, 06 Jan 2013 12:03:08 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50E47751.1070005@siemens.com> <50E59112.6080005@siemens.com>
	<50E94E72.5050309@xenomai.org> <50E95812.8050503@web.de>
In-Reply-To: <50E95812.8050503@web.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH v3] nucleus: Convert intrlock to a sleeping
	Linux lock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@siemens.com>, Xenomai <xenomai@xenomai.org>

On 2013-01-06 11:55, Jan Kiszka wrote:
> On 2013-01-06 11:14, Philippe Gerum wrote:
>> On 01/03/2013 03:09 PM, Jan Kiszka wrote:
>>
>>> +static struct xnvfile_lock_ops vfile_stat_lockops =3D {
>>> +	.get =3D xnintr_get_query_lock,
>>> +	.put =3D xnintr_put_query_lock,
>>> +};
>>> +
>>>  static struct xnvfile_snapshot stat_vfile =3D {
>>>  	.privsz =3D sizeof(struct vfile_stat_priv),
>>>  	.datasz =3D sizeof(struct vfile_stat_data),
>>>  	.tag =3D &nkpod_struct.threadlist_tag,
>>>  	.ops =3D &vfile_stat_ops,
>>> +	.entry =3D { .lockops =3D &vfile_stat_lockops },
>>>  };
>>
>> This would introduce a regression. stat_vfile's rewind/next handlers
>> compete with code altering the global thread queue which may run in
>> primary mode, such as xnpod_delete_thread() when deleting a kernel task.
>> So we can't use a linux lock to protect it.
> =

> The Linux lock is held around this rewind loop (which is still in
> place), and it is not protecting anything thread related, just the
> appearance and disappearance of IRQs. I fail to see a conflict, and
> there are also no I-pipe/Xenomai warnings triggered with this pattern.

Oh, now I see: The nklock is automatically taken if there are no
lockops. That needs to be done in the stat lockups as well, of course.
Will fix.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130106/f836c9a=
4/attachment.pgp>
