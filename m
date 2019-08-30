Subject: Re: [PATCH v4 2/2] cobalt/rtdm: allow for device teardown
References: <20190830160314.29441-1-rpm@xenomai.org>
 <20190830160314.29441-2-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <17fb261f-a958-b7ad-55c0-93906e2e7116@siemens.com>
Date: Fri, 30 Aug 2019 18:58:56 +0200
MIME-Version: 1.0
In-Reply-To: <20190830160314.29441-2-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 30.08.19 18:03, Philippe Gerum wrote:
> Currently, rtdm_dev_unregister() will hang soft until all references
> on the dismantled device have been dropped, which in turn cannot
> happen until all rtdm_fds on the device have been closed, which cannot
> happen until all references on those fds have been dropped eventually.
> Unfortunately, applications have no indication that such teardown has
> been requested, and keep sleeping on I/O channels managed by the
> dismantled device, which prevents rtdm_dev_unregister() from
> completing.
> 
> Allow for orderly device teardown by tracking all file descriptors
> representing connections active on a device, forcing each of them down
> by calling the driver's close() handler from rtdm_dev_unregister().
> Since a close() handler should abort any ongoing I/O operation on the
> channel being dismantled, any blocking I/O call on such channel should
> return on error with no additional change to the existing drivers. The
> common error code indicating an aborted I/O operation in this case is
> EBADF.
> 
> Upon receiving the error, the application is expected to close the
> stale file descriptor and/or exit, which would drop the corresponding
> file reference.
> 
> Stale file descriptors lingering in applications will still prevent
> driver modules serving them from unloading until they are eventually
> closed. Subsequent operations on a file descriptor connected to a
> device which is being torn now down lead to the EBADF error.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   include/cobalt/kernel/list.h        |  2 +-
>   include/cobalt/kernel/rtdm/driver.h |  1 +
>   include/cobalt/kernel/rtdm/fd.h     |  2 ++
>   kernel/cobalt/rtdm/core.c           | 25 ++++++++++++++++++++-----
>   kernel/cobalt/rtdm/device.c         | 24 ++++++++++++++++++++++--
>   kernel/cobalt/rtdm/fd.c             | 13 +++++++++++--
>   kernel/cobalt/rtdm/internal.h       |  6 ++++++
>   7 files changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/include/cobalt/kernel/list.h b/include/cobalt/kernel/list.h
> index 989d934b8..37b91b0d5 100644
> --- a/include/cobalt/kernel/list.h
> +++ b/include/cobalt/kernel/list.h
> @@ -45,7 +45,7 @@ do {										\
>     ({								\
>   	  __type *__item;					\
>   	  __item = list_first_entry(__head, __type, __member);	\
> -	  list_del(&__item->__member);				\
> +	  list_del(&(__item)->__member);			\

Not really needed, is it? Just trying to understand.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

