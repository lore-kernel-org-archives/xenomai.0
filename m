MIME-Version: 1.0
References: <20220302233443.14696-1-egates@cardinalpeak.com>
 <87bkylr2jm.fsf@xenomai.org>
In-Reply-To: <87bkylr2jm.fsf@xenomai.org>
From: Evan Gates <evan.gates@gmail.com>
Date: Fri, 4 Mar 2022 11:35:48 -0700
Message-ID: <CAKvFXSDej9UuG2W52hvGJh0fy1JFNOYgz2HWaPxBAepJZF1yeA@mail.gmail.com>
Subject: Re: [PATCH] meson: allow use of installed uapi headers
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Mar 4, 2022 at 11:33 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
> Thanks for this patch. We still need to merge a solution for both
> possible use cases though, as such the changes do enable back picking
> /usr/include as the uapi path, but now breaks the setup when -Duapi
> points at a full kernel tree.
>
> The issue is with uapi/asm, in this case, the source path is
> $UAPI/arch/$ARCH/include/uapi/asm, not $UAPI/asm.

Oh wow, you're absolutely right.  I'm not sure how I missed that.
And now I'm doubting my sanity because I thought I got a build working
pointing to the kernel tree.  I'll put together a v2.

Thanks,
Evan

