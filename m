Subject: Re: [I-PIPE] ipipe-core-4.9.135-x86-7 released
References: <E1gHtmu-0002xR-FI@xenomai.org>
 <653100543.20966555.1541129646273@mail.yahoo.com>
 <009db19b-cb18-095c-2fda-eb9beaa7767c@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1378793b-2c18-1e51-937c-3ce14a7bb9e9@xenomai.org>
Date: Sun, 4 Nov 2018 11:52:11 +0100
MIME-Version: 1.0
In-Reply-To: <009db19b-cb18-095c-2fda-eb9beaa7767c@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Alec Ari <neotheuser@ymail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/2/18 9:22 AM, Jan Kiszka wrote:
> On 02.11.18 04:34, Alec Ari wrote:
>> This isn't just for x86, this patch includes ppc and arm64 as well. I
>> was wondering why it was so big! Same story on the latest 4.4 patch.
> 
> Huh! Philippe, did I mess something up?
> 

ipipe-tags was only meant to receive tags from current single-arch
I-pipe trees, not the legacy ipipe.git tree, hence the issue. I need to
integrate the legacy patch generator which does the proper per-arch
split for pre-4.14 kernel releases.

-- 
Philippe.

