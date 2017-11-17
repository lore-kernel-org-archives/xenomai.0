References: <c13bf74e07b340e4a3306e9d1e96f3e9@sieb-meyer.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f9afef97-0e34-87c9-399c-f2f8af2958df@xenomai.org>
Date: Fri, 17 Nov 2017 10:21:33 +0100
MIME-Version: 1.0
In-Reply-To: <c13bf74e07b340e4a3306e9d1e96f3e9@sieb-meyer.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] list of threads with same session_label
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?H=c3=a4nel-Baas=2c_Alexander?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/16/2017 01:45 PM, Hänel-Baas, Alexander wrote:
> Hi,
> we use Xenomai's tuneable "session_name" to set the same session of our threads.
> to do this, we used your example "Adding your own setup code" described in "application-setup-and-init" and
> attach this lib to the application.
> It works fine.
> 
> My Question:
> How can I list all threads that live in the same session?
> 

Assuming alchemy is your API, enable the user-space registry with 
--enable-registry when configuring. Your application will automatically 
maintain /var/run/xenomai/<user>/<session>/alchemy/tasks. Reading from 
this file should give you the information needed.

The kernel side is not aware of the session mechanism, so you won't find 
any reference to it under the /proc/xenomai hierarchy.

-- 
Philippe.

