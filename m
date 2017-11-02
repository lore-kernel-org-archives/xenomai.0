References: <CAHoW4hF15haWApb+tY6cgyZrZ2ZX4Ls2CHUK5J-NchWvAeBMNA@mail.gmail.com>
 <9e406692-f2d1-465b-0c67-dc408d6a366a@xenomai.org>
 <CAHoW4hH+W3anUTgsTf8cdjo=BHeXztD5JD-O3j1WcPcYMNGA5g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3ff3bb4a-a2a4-6593-b57a-9b9cb32a8cdd@xenomai.org>
Date: Thu, 2 Nov 2017 19:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hH+W3anUTgsTf8cdjo=BHeXztD5JD-O3j1WcPcYMNGA5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Call to heapobj_pkg_init_private() in
 copperplate_init() locks unneeded pages into memory when
 CONFIG_XENO_PSHARED is set
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 11/02/2017 02:10 PM, Charles Kiorpes wrote:
> On Wed, Nov 1, 2017 at 4:58 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Good catch. However, some APIs may need to create private heaps along with a shared main heap, so we can't disable the init entirely. We can reduce the impact of creating the temporary heap in the shared case though. Could you try this alternative approach and let me know if that works for you?
> 
> Ah, ok.  Reducing the impact makes sense.
> 
> I did some testing with the provided patch.  I was seeing a segfault
> in init_memory_pool(), because heapobj_pkg_init_private() passes
> __copperplate_setup_data.mem_pool into init_memory_pool(), and also
> uses that value to calculate the tlsf_pool_overhead.  Changing these
> operations to use the reduced pool size eliminated the segfault.
> Here's a modified version that makes sure that the variable pool size
> is propagated throughout the function:
> 
> diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
> index e24db15..3709852 100644
> --- a/lib/copperplate/heapobj-tlsf.c
> +++ b/lib/copperplate/heapobj-tlsf.c


Ok, let's merge this. Could you send back a complete patch formatted
with "git format-patch"? TIA,

-- 
Philippe.

