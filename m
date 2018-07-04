References: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
 <f91caf3e-5b65-298a-1ac6-91697eed90c3@xenomai.org>
 <00a901d40f76$771290d0$6537b270$@sepro-group.com>
 <56e66ad7-91b7-2b6a-f953-507d2493a27e@xenomai.org>
 <002f01d4136c$3bdf9090$b39eb1b0$@sepro-group.com>
 <4d8d5350-df55-a670-f929-57b9b45353a4@xenomai.org>
 <007d01d4139a$adfff0b0$09ffd210$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4dd70d36-9951-ce4a-293d-783f48c6c245@xenomai.org>
Date: Wed, 4 Jul 2018 16:00:11 +0200
MIME-Version: 1.0
In-Reply-To: <007d01d4139a$adfff0b0$09ffd210$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Assertion current-magic 0 failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Reichert?= <sreichert@sepro-group.com>, xenomai@xenomai.org

On 07/04/2018 03:26 PM, Stéphane Reichert wrote:
> Hi Philippe,
> 
> Unfortunately, we did not disable auto-init.
> 
> Maybe the fact that rt_heap_bind is called from a shared library could be 
> the problem ?

Does that code run over a constructor routine (i.e. tagged with
__attribute__((constructor))?

> 
> I joined the 2 executables we are using. In order to reproduce the problem, 
> you have to run these commands:
> ./start_lib_ipc --session=rct &
> ./tests_integration_lib_ipc --session=rct CH1 &
> 
> The shared library lib_ipc.so contains the call to rt_heap_bind.
> 

Ok, I'll have a look. Thanks.

-- 
Philippe.

