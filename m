Subject: Re: FW: [PATCH] lib/cobalt: init: do not call pthread_atfork() from
 atfork() handlers
References: <20190503150939.3594-1-rpm@xenomai.org>
 <VI1PR05MB591765785A35FB3685463256F6300@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <6ef3a9cf-cb30-59c4-1983-4475fdc7cd6e@xenomai.org>
 <c0230398-8da5-a0b4-d30c-17e91e2f0cb7@xenomai.org>
 <DB8PR05MB5915F745C3CA952C04179E2EF6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <69740012-4273-4647-00a2-55fd7ad9468d@xenomai.org>
 <DB8PR05MB5915BB62DD6315DB14C4CF04F6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <DB8PR05MB59150F0E1F3A6E0C28AC4CFEF6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <534d4331-cad3-908c-6677-3186e12ef70b@xenomai.org>
Date: Tue, 14 May 2019 16:01:35 +0200
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB59150F0E1F3A6E0C28AC4CFEF6080@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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

On 5/14/19 12:40 PM, Lange Norbert wrote:
> What do you think about this hackaround?
> Still not "clean" to call in a signal handler but it does work.

Yes, this is documented as such in backtrace() as the recommended work
around for this situation. I would add this stuff to install_sigshadow()
instead though, because this is why/where we need that in the first place.

-- 
Philippe.

