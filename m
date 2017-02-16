References: <1487178823-4062-1-git-send-email-tbultel@pixelsurmer.com>
 <d6015da2-8e58-22df-6790-661f811d4cdc@xenomai.org>
From: thierry bultel <tbultel@pixelsurmer.com>
Message-ID: <1a426ec2-bf20-f774-08e5-1d9c9aada723@pixelsurmer.com>
Date: Thu, 16 Feb 2017 11:25:06 +0100
MIME-Version: 1.0
In-Reply-To: <d6015da2-8e58-22df-6790-661f811d4cdc@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] automake: add a conditionnal to rt devices
 install
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org



Le 16/02/2017 =E0 10:19, Philippe Gerum a =E9crit :
> On 02/15/2017 06:13 PM, Thierry Bultel wrote:
>> When cross building from a build system (like buildroot),
>> it is not convenient to get the sudo prompt for the installation
>> of cobalt rt devices.
>> Calling mknod is the responsibility of the build system, that
>> will perform it under a fakeroot environnement
>> The fix simply checks the existence of NO_RT_DEVICES environment
>> that can be set when bootstrapping
>> ---
>>  Makefile.am  | 2 ++
>>  configure.ac | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>
> Thanks, however this is duplicating an existing mechanism:
>
> $ make SUDO=3Dfalse install
>
> see install-user rule in the toplevel Makefile.
>
> This said, Xenomai 3 expects udev/mdev to be enabled, so most of the
> devices rule in that Makefile is useless now; at least the install rule
> should not implicitly chain to it via install-exec-local.
>
Thanks,
sorry to have missed that

