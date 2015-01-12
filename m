Message-ID: <54B3DB8E.4020805@siemens.com>
Date: Mon, 12 Jan 2015 15:34:54 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54A6A387.4010109@web.de> <20150102141625.GD1492@daedalus>
 <20150102150638.GE1492@daedalus> <54A6C072.7020303@web.de>
 <20150103194050.GH12052@daedalus> <54A84E6E.2040501@web.de>
 <20150103222509.GA6409@hermes.click-hack.org> <54AD77A0.1010206@siemens.com>
 <20150112104200.GD25855@hermes.click-hack.org> <54B3ADB8.3010901@siemens.com>
 <20150112113415.GG25855@hermes.click-hack.org> <54B3B715.2000109@siemens.com>
 <54B3DBA9.5040905@xenomai.org>
In-Reply-To: <54B3DBA9.5040905@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-01-12 15:35, Philippe Gerum wrote:
> On 01/12/2015 12:59 PM, Jan Kiszka wrote:
>> On 2015-01-12 12:34, Gilles Chanteperdrix wrote:
>>> On Mon, Jan 12, 2015 at 12:19:20PM +0100, Jan Kiszka wrote:
>>>> On 2015-01-12 11:42, Gilles Chanteperdrix wrote:
>>>>> On Wed, Jan 07, 2015 at 07:14:56PM +0100, Jan Kiszka wrote:
>>>>>> On 2015-01-03 23:25, Gilles Chanteperdrix wrote:
>>>>>>>>>
>>>>>>>>> Alternatively (to the last item), the sysregd could be made suid
>>>>>>>>> root, create the session directory if it does not exist with root
>>>>>>>>> permissions but with the target user as owner, then drop root
>>>>>>>>> privileges and continue as a normal user.
>>>>>>>>
>>>>>>>> Should work, but unless I stumbled over fundamental issues why sysregd
>>>>>>>> is not working as normal user right now, I don't see a technical need
>>>>>>>> for this big hammer for user-managed sessions.
>>>>>>>
>>>>>>> The enormous advantage of using the big hammer (in fact, only if we
>>>>>>> put the three changes into it), is that it avoids explaining things
>>>>>>> to the users, and avoids as well questions on the mailing list.
>>>>>>> Given the number of questions we have had about /dev/rtheap and
>>>>>>> /dev/rtpipe, this would be a win.
>>>>>>
>>>>>> We actually need the big suid-hammer: only root has the permission to
>>>>>> clean up the mounts of other users. Obsoletes my fusermount -u patch.
>>>>>
>>>>> Why does root need to clean up the mounts of other users if each
>>>>> user cleans up its mounts ?
>>>>
>>>> As long as the daemon only runs on behalf of the very same user, this
>>>> works. But this breaks when user A starts a session and B joins it or
>>>> inherits a still running daemon.
>>>
>>> Is it really a case that matters ? As I already said, I believe
>>> running xenomai programs as simple user should be taken into
>>> account, but multiple users for the same session ?
>>
>> If that is not required, we could make the mount point private in $HOME.
>> Then it is clear to the user that sessions cannot be shared. And the
>> namespaces would be isolated automatically.
>>
>> Anon will continue to require a root daemon that has to be started in
>> advance.
>>
> 
> Looks ok. Named sessions have been designed as a way to share things
> between processes composing a larger application, basically. Assuming
> that all processes sharing a named session must belong to the same uid
> is part of the original design.

OK, then let's sketch a design:

- if sysregd runs as non-root, it uses $HOME/.xenomai as default
  (open for alternative suggestions as well -
  DEFAULT_REGISTRY_ROOT/$USER?) registry root, otherwise
  DEFAULT_REGISTRY_ROOT. Overriding via --root remains unaffected.

- remove --shared-registry application option, only provide
  "sysregd --shared" because we need it for the anon session

- do not install sysregd with suid

Makes sense?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

