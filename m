References: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
 <d9e08992-4083-3c1a-06ee-1a36a2fbdd3a@xenomai.org>
 <trinity-71d48a15-4ece-4d49-b012-73220dfbbc6f-1539873444067@msvc-mesg-gmx123>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2d0b645e-d23b-db0f-ea66-17dc8a75e918@xenomai.org>
Date: Fri, 19 Oct 2018 09:16:07 +0200
MIME-Version: 1.0
In-Reply-To: <trinity-71d48a15-4ece-4d49-b012-73220dfbbc6f-1539873444067@msvc-mesg-gmx123>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] boilerplate/avl: fix missing include
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: xenomai@xenomai.org

On 10/18/2018 04:37 PM, Sebastian Smolorz wrote:
> 
> Nevertheless, I guess there is an issue with the definition of const (line 50) in
> include/boilerplate/compiler.h. It does work with gcc 5.4 but not with
> gcc 4.3.5.
> 

Could you elaborate on this? Which error pops us, in which context?

Thanks,

-- 
Philippe.

