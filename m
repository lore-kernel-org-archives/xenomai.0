Subject: Re: Posix skin and Mutex initialisation/destruction inconsistencies
References: <0e040cd1aa3b4df6ba3c61eb6c1a4adf@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a289496-aad1-5a44-d4bb-288ccc12d68a@siemens.com>
Date: Wed, 6 Mar 2019 18:35:00 +0100
MIME-Version: 1.0
In-Reply-To: <0e040cd1aa3b4df6ba3c61eb6c1a4adf@andritz.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 06.03.19 10:39, Lange Norbert via Xenomai wrote:
> Hello,
> 
> 1)
> There is an inconsistency with the documentation [1], which claims that mutex and condition variables
> need to be explicitly initialized with the *_init functions.
> The implementation however checks the state via a flag and calls *_init if necessary, and the program below works correctly.

Lazy init is not a recommended pattern as it implies high costs and potentially 
unexpected (and often unhandled) errors for typically critical lock/unlock 
operations. I would guess that this is why it was not explicitly mentioned.

> 
> 2)
> There is some further issue, if you depend on the "lazy initialization", demonstrated by running the
> program below with an argument. This case can happen for example if some subsystem was removed
> before being used (never needed the lock).
> In other words, the "lazy initialization" scheme is working with lock/unlock but not with destroy.
> 
> 
> #include <assert.h>
> #include <pthread.h>
> 
> int main(int argc, char const *argv[]) {
>          pthread_mutex_t mymutex = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
> 
>    if (argc == 1) {
>      assert(0 == pthread_mutex_lock(&mymutex));
>      assert(0 == pthread_mutex_unlock(&mymutex));
>    }
>    assert(0 == pthread_mutex_destroy(&mymutex));

That should probably be fixed. Patch welcome.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

