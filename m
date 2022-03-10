References: <20220304190205.24489-1-egates@cardinalpeak.com>
 <20220307183146.24784-1-evan.gates@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v3] meson: allow use of installed uapi headers
Date: Thu, 10 Mar 2022 10:50:52 +0100
In-reply-to: <20220307183146.24784-1-evan.gates@gmail.com>
Message-ID: <87r17af853.fsf@xenomai.org>
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

Merged, thanks.

-- 
Philippe.

