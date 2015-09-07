References: <CAJqUr7zJXoASSpTr=Y8ZOzDDhWruZU9BVTbQ3YViqm7Lf8kTMA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55EDB48F.7010800@xenomai.org>
Date: Mon, 7 Sep 2015 18:00:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAJqUr7zJXoASSpTr=Y8ZOzDDhWruZU9BVTbQ3YViqm7Lf8kTMA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [pull request] xenomai-3/arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>, xenomai@xenomai.org

On 09/02/2015 11:22 PM, Don Mahurin wrote:
> Pull request for xenomai-3/arm64, fixing tracing/syscall prints for arm64.
> 
> The following changes since commit ef3d72d9825eb5ce3a75b93b6b4b4104f7c41db0:
> 
>   cobalt/arm64: machine.h: use slightly faster ffnz implementation
> (2015-06-17 16:09:20 -0700)
> 
> are available in the git repository at:
> 
>   http://gitlab.mperpetuo.com/it/xenomai-3.git arm64
> 
> for you to fetch changes up to ab0f4e2e24830c67600270789fd2ce2811c2ce60:
> 
>   cobalt/arm64: pc and orig_r0 are u64 on arm64 and 'unsigned long' or arm
> and other platforms. printf referencing these are using %lx. On arm64, long
> and long long (and u64) are 64 bits. Rather than changing printf format,
> chnage arm64 macros to cast to unsigned long. (2015-09-02 13:48:36 -0700)

The change is fine by me. Please substitute a proper short log for this
commit, using the existing description for the long one.

Thanks,

-- 
Philippe.

