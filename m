References: <1486421551-31257-1-git-send-email-dmitriy@mperpetuo.com>
 <3b4ebffe-e114-1c35-72e9-3fab0c962981@xenomai.org>
From: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Message-ID: <775998af-a7e2-c53c-fe3b-22dea4155bcc@mperpetuo.com>
Date: Tue, 7 Feb 2017 10:03:44 -1000
MIME-Version: 1.0
In-Reply-To: <3b4ebffe-e114-1c35-72e9-3fab0c962981@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe: add missing drivers to genpatches
 script for arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 02/07/2017 12:32 AM, Philippe Gerum wrote:
>
> This patch would break the ARM32 side. This is an associative array
> shared by all archs. The logic of genpatches.sh needs significant rework
> for handling the case of driver code shared by multiple archs.
>

Ah yes, I see what you mean. I'll take another look.

-Dmitriy

