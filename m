References: <20220302233443.14696-1-egates@cardinalpeak.com>
 <20220304190205.24489-1-egates@cardinalpeak.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2] meson: allow use of installed uapi headers
Date: Sat, 05 Mar 2022 11:11:50 +0100
In-reply-to: <20220304190205.24489-1-egates@cardinalpeak.com>
Message-ID: <877d98r9fm.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Evan Gates <evan.gates@gmail.com>
Cc: xenomai@xenomai.org


Evan Gates via Xenomai <xenomai@xenomai.org> writes:

> Commit c70a9d9d536aefcf6574328aaac0fcc86f9ab0f7 added a test for
> $UAPI/include/uapi/evl that was meant to ensure the given $UAPI path was
> correct.  That test meant that $UAPI had to point to a linux-evl source
> directory and could not point to installed headers in e.g. /usr/include.
> The script had previously allowed the use of installed headers, using
> the existence of $UAPI/Kbuild as an heuristic to decide whether $UAPI
> pointed to linux-evl source or to installed headers.
>
> Rewrite the script to check for the existence of all three required
> directories in either location.  This allows the use of installed
> headers again.
>
> Fixes: c70a9d9 (build: tighten consistency check for uapi)
> ---

Works nicely against a full kernel tree now, thanks. Please send v3 with
a sign-off line added to the commit log so that your patch may be
merged.

-- 
Philippe.

