References: <1534230470-3290-1-git-send-email-sebastian.smolorz@gmx.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56f43c3f-36e1-23aa-7026-110f551ccb84@xenomai.org>
Date: Wed, 15 Aug 2018 16:16:09 +0200
MIME-Version: 1.0
In-Reply-To: <1534230470-3290-1-git-send-email-sebastian.smolorz@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] net: Split internal rtnet.h into rtdm/net.h
 and rtdm/uapi/net.h and install them
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 08/14/2018 09:07 AM, Sebastian Smolorz wrote:
> For external projects wanting to use RTnet with its special
> features like RTnet IOCTLs it is necessary to provide the API
> headers in the Xenomai installation directory.

Assuming there is no ABI change, and net/stack/include/rtnet.h was not
part of any external API, do you push this for inclusion in the -stable
branch too?

-- 
Philippe.

