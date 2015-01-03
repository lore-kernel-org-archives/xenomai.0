Message-ID: <54A84E6E.2040501@web.de>
Date: Sat, 03 Jan 2015 21:17:50 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <54A672BA.8090209@web.de> <54A679D5.20903@xenomai.org>
 <54A67CD1.10103@web.de> <54A69D42.2010408@xenomai.org>
 <54A69BFA.7060405@web.de> <54A6A506.3060504@xenomai.org>
 <54A6A387.4010109@web.de> <20150102141625.GD1492@daedalus>
 <20150102150638.GE1492@daedalus> <54A6C072.7020303@web.de>
 <20150103194050.GH12052@daedalus>
In-Reply-To: <20150103194050.GH12052@daedalus>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum: copperplate: add
 configuration tunable for registry moint point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-01-03 20:40, Gilles Chanteperdrix wrote:
> On Fri, Jan 02, 2015 at 04:59:46PM +0100, Jan Kiszka wrote:
>> On 2015-01-02 16:06, Gilles Chanteperdrix wrote:
>>> To explain a bit more completely. We can not assume that xenomai
>>> applications are running as root user. And non root user are not
>>> allowed to create /run/xenomai or /var/run/xenomai (at least not on
>>> debian or slackware). What is more, these directories being
>>> typically non persistent, a script has to be modified somewhere to
>>> add mkdir /var/run/xenomai at every boot. On the other hand, mkdir
>>> /mnt/xenomai has to be done once and only once, in the "make
>>> install" phase for instance, since "make install" is run as root,
>>> except that if /mnt is read-only it will not work. But not many
>>> users are running system where they compile and run things with root
>>> filesystem read-only. Anyway, the two cases are really similar, no
>>> one is advantageous over the other. We are going to see questions on
>>> the mailing list about that, whatever we do. Perhaps adding a small
>>> kernel module to create /proc/xenomai/registry would make things
>>> simpler...
>>>
>>
>> Non-root users are indeed an interesting new aspect. However, the
>> solution to make a central directory writable seems weird to me. If you
>> want to allow non-root users to access the registry, it would be way
>> more logical to either shoot up a single privileged sysregd that
>> everyone can talk to or use private instances that also run against
>> their own per-user mount points, likely located in $HOME.
> =

> The solution which works for every case is to add a boot script
> which:
> =

> - creates the mount point (and ignore failure if the system is
> read-only, as it is then the responsibility of whoever creates the
> file system to create the mount point, ignore also failure if the
> mount point already exists);
> =

> - mount a tmpfs on the mount point if the file system is read-only,
> and fail if the mount point does not exist
> =

> - change the directory permission to allow all users of the e.g.
> xenomai group to write to this directory.

Exactly. That would be reasonable at least for the anon session and
anything that the sysadmin would like to appear for everyone in the
Xenomai group. The users would still be free to start their own private
daemons for local sessions.

> =

> Alternatively (to the last item), the sysregd could be made suid
> root, create the session directory if it does not exist with root
> permissions but with the target user as owner, then drop root
> privileges and continue as a normal user.

Should work, but unless I stumbled over fundamental issues why sysregd
is not working as normal user right now, I don't see a technical need
for this big hammer for user-managed sessions.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150103/4278d1a=
0/attachment.sig>
