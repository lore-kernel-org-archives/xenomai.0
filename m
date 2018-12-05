From: Philippe Gerum <rpm@xenomai.org>
Subject: [I-PIPE] ipipe-core-4.9.135-x86-7 released
References: <E1gHtmu-0002xR-FI@xenomai.org>
 <653100543.20966555.1541129646273@mail.yahoo.com>
 <009db19b-cb18-095c-2fda-eb9beaa7767c@siemens.com>
 <1378793b-2c18-1e51-937c-3ce14a7bb9e9@xenomai.org>
Message-ID: <af13cc5e-a076-5618-e8f2-a62284a8493c@xenomai.org>
Date: Wed, 5 Dec 2018 16:24:17 +0100
MIME-Version: 1.0
In-Reply-To: <1378793b-2c18-1e51-937c-3ce14a7bb9e9@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/4/18 11:52 AM, Philippe Gerum via Xenomai wrote:
> On 11/2/18 9:22 AM, Jan Kiszka wrote:
>> On 02.11.18 04:34, Alec Ari wrote:
>>> This isn't just for x86, this patch includes ppc and arm64 as well. I
>>> was wondering why it was so big! Same story on the latest 4.4 patch.
>>
>> Huh! Philippe, did I mess something up?
>>
> 
> ipipe-tags was only meant to receive tags from current single-arch
> I-pipe trees, not the legacy ipipe.git tree, hence the issue. I need to
> integrate the legacy patch generator which does the proper per-arch
> split for pre-4.14 kernel releases.
> 

The two botched patches in
https://www.xenomai.org/downloads/ipipe/v4.x/x86/ were moved to the
trashed/ subdir. ipipe-core-4.4.162-x86-11 and ipipe-core-4.9.135-x86-7
have been deleted from ipipe-tags, so that you can resubmit if you plan to.

In addition to the patch generation issue, a couple of other things were
found in the x86 tree for those releases:

- the revision tag in arch/x86/include/asm/ipipe.h was not updated,
therefore did not match the git tag.

- since the patch bot in ipipe-tags relies on genpatches.sh for
multi-arch trees, this script should be tested before a new tag is sent
to  ipipe-tags. Running scripts/ipipe/genpatches.sh is enough.

- 4.9.135 was pushed with a build left-over
(drivers/scsi/scsi_devinfo_tbl.c).

A couple of patches addressing some of these issues will be following
soon. The genpatches.sh fixup should be merged into 4.9 and 4.4.

I've fixed and tested the patch bot which now works with the legacy
multi-arch tree too. You have all options open: re-issue
ipipe-core-4.4.162-x86-11 and ipipe-core-4.9.135-x86-7 to ipipe-tags
(ideally after a rev. tag update in ipipe.h), ask me to reinstate the
trashed  patches and go for a better next release, any other option that
makes sense in your view.

-- 
Philippe.

