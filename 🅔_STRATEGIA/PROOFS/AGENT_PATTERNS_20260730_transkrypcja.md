# TRANSKRYPCJA — jezyk: en, dlugosc: 00:36:10

[00:00:00] Agents are all the rage, but building them and making them reliable is a real challenge.
[00:00:04] I'll show you how to do it right now.
[00:00:06] So this agent.py is a Python script that I'm going to use to lay out my agent.
[00:00:11] And first, I'm just going to import a model here.
[00:00:14] I'll use chat-anthropic.
[00:00:15] And I'll use, I'll define a few different tools.
[00:00:18] In this case, we'll make it really simple toy example,
[00:00:20] an add tool, a multiply tool, a divide tool, okay?
[00:00:24] So those are the tools I want my agent to use.
[00:00:26] I define those as a list.
[00:00:28] And I go ahead and bind those to chat-anthropic.
[00:00:32] I'll use clod3-sonnet.
[00:00:34] Now this is using LangChain's integration with anthropic.
[00:00:39] And so you see this bind-tools method is very conveniently available.
[00:00:42] So that's how we bind our tools to RLM.
[00:00:44] So now we have this model with tools.
[00:00:46] I want to use this as an agent.
[00:00:48] LangGraph makes that very easy to do.
[00:00:51] So in LangGraph, you can think about,
[00:00:53] think about the steps you want your agent to take.
[00:00:56] Each step is basically a node,
[00:00:58] and then steps can be connected with edges.
[00:01:00] So basically LangGraph expresses control flows
[00:01:02] that agents can take as graphs with nodes and edges.
[00:01:05] Now this is a really simple one,
[00:01:07] where I just have a single node that's my assistant node,
[00:01:10] and it's basically going to call the model we defined up here.
[00:01:14] Now I see something else that's pretty cool.
[00:01:16] LangGraph has what we call state.
[00:01:18] States would allow you,
[00:01:20] allows you to pass information between nodes.
[00:01:23] So this state is basically this built-in messages state object,
[00:01:26] which is part of LangGraph,
[00:01:28] which basically contains a number of keys.
[00:01:31] One of the keys built into state is this messages key.
[00:01:34] So what we're doing in this node is we're calling the chat model,
[00:01:38] and we're basically just returning the output of the model
[00:01:41] to the messages key, okay?
[00:01:44] So you can think about it as LangGraph lets you lay out agents
[00:01:47] as graphs with nodes and edges.
[00:01:49] Each node can interact with a state variable,
[00:01:52] and this state is what you use to transmit information across your agent.
[00:01:56] So here we can just lay out our agent.
[00:01:58] We're going to go ahead and add our nodes.
[00:02:00] One is the assistant node, one is that tools node.
[00:02:03] For that tools node we pass our list of tools we defined up here.
[00:02:06] And we can lay out the logic.
[00:02:08] So basically edges set the logic of our agent.
[00:02:11] So we can basically start, we'll go to the assistant node.
[00:02:14] We add this conditional edge to go to the tools node,
[00:02:18] or just back to the assistant and end.
[00:02:20] So that's how you can lay out an agent really simply
[00:02:23] as a Python script using LangGraph,
[00:02:25] and all you then do is builder.compile.
[00:02:27] That's how you compile your agent, okay?
[00:02:29] This agent graph.
[00:02:31] Now what do you do then?
[00:02:32] So we have a very nice library called LangGraph Studio,
[00:02:36] which is part of LangGraph that allows you to visualize these.
[00:02:40] So I'll go ahead and open that right now.
[00:02:42] This is that agent we just built in studio.
[00:02:45] So this is a nice IDE where I can actually look at the layout of my agent.
[00:02:48] Start, I go to my assistant node.
[00:02:50] That's where I'm going to call my chat model.
[00:02:52] My chat model may decide to call a tool.
[00:02:55] If so, goes to the tools node using that conditional edge.
[00:02:58] That conditional edge looks at the output, goes to the tools node,
[00:03:01] and then goes back to the assistant.
[00:03:03] And this will repeat until no more tool call.
[00:03:06] Then we end.
[00:03:07] So that's basically the layout of our agent.
[00:03:09] Now let's go ahead and try to test this out.
[00:03:12] I can create a new thread,
[00:03:14] and I can basically select the agent.
[00:03:18] And I'll pass an input, say multiply two and three, submit.
[00:03:24] And we can see the assistant's running.
[00:03:26] Claude is responding.
[00:03:28] It decides to make a tool call.
[00:03:29] Tool call is made.
[00:03:31] And then we end.
[00:03:32] So it's nice about LangGraph Studio is it gives you a really good
[00:03:35] kind of visual experience to debug and test your agents
[00:03:38] that you build using LangGraph.
[00:03:40] So it's all connected.
[00:03:42] And you can even use LangGraph Cloud to deploy it.
[00:03:44] So that's like a very nice way you can kind of lay out
[00:03:47] and test agents in LangGraph.
[00:03:49] So that's just a very brief taste of LangGraph
[00:03:51] and how it works.
[00:03:52] We actually showed you how to lay out an agent in LangGraph
[00:03:55] as a Python script and then visualize it
[00:03:57] and debug it in LangGraph Studio, a visual IDE.
[00:04:00] So really what I want to take away from this is
[00:04:02] LangGraph is a great way to build agents.
[00:04:04] That can be reliable.
[00:04:05] You can test them really easily in LangGraph Studio.
[00:04:07] And if you want to learn more,
[00:04:09] go to the link in the description,
[00:04:11] which is for LangChain Academy.
[00:04:13] It's a free course that kind of walks you through
[00:04:15] LangGraph from scratch and I taught it all free to use
[00:04:18] and I'll show you how to do all this in a lot more detail.
[00:04:21] Thanks.
[00:04:22] A topic recently about this blog post
[00:04:24] called Building Effective Agents,
[00:04:26] where they define what an agent is
[00:04:28] and also explain what a workflow is.
[00:04:30] So I'm going to build every workflow and agent
[00:04:33] that they talk about in this blog post from scratch
[00:04:35] and explain what they all are, how to build them
[00:04:38] and why each one can be very useful.
[00:04:40] So here's a simple way to think about their definition
[00:04:43] of a workflow versus an agent.
[00:04:45] Think about a workflow as some kind of scaffolding
[00:04:48] of predefined code paths around LLM calls.
[00:04:51] Now this has been popular for years
[00:04:53] and it makes a lot of sense in many cases
[00:04:55] to take LLM calls and embed them
[00:04:57] in some fixed set of code paths.
[00:05:00] Now sometimes you can actually have that LLM decide
[00:05:03] what path to take in a workflow
[00:05:06] and that's kind of middle category that I drew here.
[00:05:09] And we'll talk about all these in detail.
[00:05:11] But that's kind of the intuition.
[00:05:13] Workflows are kind of like some scaffolding
[00:05:15] of predefined code paths
[00:05:17] and you can embed LLM calls within it.
[00:05:19] Now agents remove the scaffolding.
[00:05:23] So you're basically let an LLM direct its own actions.
[00:05:27] Now in this particular case, actions are typically tool calls
[00:05:30] and an LLM will receive the feedback
[00:05:33] from those tool calls and decide what to do next.
[00:05:36] I do want to call out that you can certainly
[00:05:38] have LLMs that perform tool calls
[00:05:40] within workflows.
[00:05:42] But the difference is that workflows
[00:05:44] have some scaffolding around them
[00:05:46] whereas an agent is unbounded.
[00:05:49] So an agent just directly receives the output
[00:05:52] of environmental feedback from
[00:05:54] tool calls, decides what to do next
[00:05:56] without the kind of reasoning scaffolding around it.
[00:05:59] So that's really differentiation.
[00:06:01] Now just before it gets started here, it's important to call out
[00:06:03] why frameworks.
[00:06:05] So implementing these patterns doesn't require framework.
[00:06:08] Sometimes this can be done in a few lines of code.
[00:06:10] I completely understand that.
[00:06:12] So you might say, okay, why are you talking about this?
[00:06:14] Why are you trying to promote frameworks?
[00:06:16] Here's kind of my take on it.
[00:06:18] Langrath really aims to minimize the overhead
[00:06:20] of implementing these patterns.
[00:06:22] It doesn't abstract prompts.
[00:06:25] It doesn't abstract architecture.
[00:06:27] What's really happening with Langrath is
[00:06:29] it's supporting infrastructure underneath
[00:06:31] any workflow or agent.
[00:06:33] That's the key point.
[00:06:35] And really it's three things.
[00:06:37] One is persistence.
[00:06:39] This gives you memory.
[00:06:41] This gives you human loops, the ability to pause,
[00:06:43] for example, while an agent is processing,
[00:06:45] and approve a tool call.
[00:06:47] Pause and review what the agent is doing.
[00:06:49] This is extremely useful in many cases.
[00:06:51] Streaming.
[00:06:53] So of course, LMAPI stream tokens.
[00:06:55] We all know that.
[00:06:57] But when you build these workflows or agents,
[00:06:59] sometimes you want to stream, for example,
[00:07:01] what certain steps output,
[00:07:03] you might want to stream the outputs of tool calls.
[00:07:05] You want more flexibility over streaming
[00:07:07] than just what the LLM calls produce.
[00:07:09] And so Langrath give you a lot of control
[00:07:11] over what you're outputting
[00:07:13] from your workflow or agent.
[00:07:15] And this is very useful when actually building
[00:07:17] these and putting them in production.
[00:07:19] And the third is deployment.
[00:07:21] So testing, debugging, and deploying,
[00:07:23] that is a big benefit of using Langrath.
[00:07:25] It is extremely easy to go from
[00:07:27] any workflow or agent you implement
[00:07:29] to a deployment.
[00:07:31] Langrath doesn't abstract prompts
[00:07:33] and it does not abstract architecture.
[00:07:35] It's really giving you low-level infrastructure
[00:07:37] that sits underneath any of these
[00:07:39] workflows or agents. So now we've laid the foundations.
[00:07:41] Let's talk through the various patterns
[00:07:43] laid out in the blog post.
[00:07:45] First, starting with the augmented LLMs
[00:07:47] can be augmented with many different things.
[00:07:49] One is, for example, memory.
[00:07:51] We talked a little bit about that.
[00:07:53] That's one of the things that a framework, such as Langrath, can provide.
[00:07:55] Also, LLMs can interact with tools.
[00:07:57] And this is the foundation for building
[00:07:59] many workflows and agents.
[00:08:01] First from scratch. Here's my notebook.
[00:08:03] I've just pip-installed a few packages.
[00:08:05] Set my entire project API key.
[00:08:07] Create my LLM.
[00:08:09] Now let's show the augmentation for structured output.
[00:08:11] I can take a schema, in this case a
[00:08:13] dynamic model.
[00:08:15] I can bind it to my LLM
[00:08:17] in this particular case I'm using Langchain
[00:08:19] and I'm going to use the with structured output method
[00:08:21] in Langchain to do this. But again,
[00:08:23] Langrath does not require you to use Langchain.
[00:08:25] You can use the raw model APIs.
[00:08:27] It's completely fine.
[00:08:29] And the output adheres to my schema
[00:08:31] which I passed here. So that's great.
[00:08:33] Now let's do the same with tool calling.
[00:08:35] I'm going to take a tool. I'm going to
[00:08:37] basically define this function
[00:08:39] multiply as a tool that the LLM has
[00:08:41] access to. I can use the bind tools
[00:08:43] method in Langchain
[00:08:45] to bind it to my LLM.
[00:08:47] Now I have an LLM with tools.
[00:08:49] I invoke it with an input that's
[00:08:51] likely to elicit the tool call
[00:08:53] and I get the output.
[00:08:55] Great. You can see
[00:08:58] a tool call is produced.
[00:09:00] It takes this input
[00:09:02] and creates the arguments
[00:09:04] necessary to actually run this function.
[00:09:06] That's it. Remember when LLMs
[00:09:08] are creating tool calls, they're really just giving you
[00:09:10] payloads to actually run that tool.
[00:09:12] You can then run the tool, pass
[00:09:14] the output of the tool back to the LLM
[00:09:16] and really doing that loop gives you
[00:09:18] an agent like we saw before. We've talked about
[00:09:20] augmented LLM as a core building block.
[00:09:22] Now let's talk about some of the workflow patterns
[00:09:24] covered in the blog post. Starting
[00:09:26] with prompt chaining. Here's the intuition.
[00:09:28] Each LLM call processes the output
[00:09:30] of the previous one. When do you
[00:09:32] want to do this? When you have a task
[00:09:34] you can decompose into a few
[00:09:36] different LLM calls. So in this little
[00:09:38] example they show, there's an input
[00:09:40] call one. You can have some
[00:09:42] gating on the output of call one.
[00:09:44] Output goes to call two.
[00:09:46] That output goes to call three.
[00:09:48] So let's especially build this from scratch
[00:09:50] and let's do an example where we build a chain
[00:09:52] that takes a topic from a user.
[00:09:54] The LLM makes a joke.
[00:09:56] We check to make sure the joke has
[00:09:58] a punchline and we improve it twice
[00:10:00] with two subsequent LLM calls. Now
[00:10:02] when I'm working in Langraph, all I need
[00:10:04] to do is basically define a container
[00:10:06] for everything that I want to modify
[00:10:08] over my workflow.
[00:10:10] So in this particular case
[00:10:12] I'm just going to create a dict
[00:10:14] and it's going to contain topic that's
[00:10:16] will get from the user. The joke will be
[00:10:18] the output of that first call. Improved
[00:10:20] joke will be the output of the second call.
[00:10:22] Improved joke will be the output of the final call.
[00:10:24] Now when laying out workflows, I actually
[00:10:26] like to draw them out anyway so this is kind
[00:10:28] of cool that the blog post has all these laid out
[00:10:30] and when you draw these out, think about
[00:10:32] for example, each of these calls
[00:10:34] or steps is just a different
[00:10:36] function. So for this particular
[00:10:38] workflow I'm going to create a function
[00:10:40] generate joke, improve joke, polish
[00:10:42] joke and
[00:10:44] those are all going to be just simple LLM
[00:10:46] calls. Now what's interesting
[00:10:48] is with Langraph, this
[00:10:50] container or state that I define
[00:10:52] is passing to every one of these steps
[00:10:54] and I can extract whatever
[00:10:56] I want from it. In this case I go state
[00:10:58] topic to get the topic
[00:11:00] that is written to state by the user
[00:11:02] and I can write things back to state
[00:11:04] just by basically
[00:11:06] returning this
[00:11:08] joke key, the output
[00:11:10] of my LLM call.
[00:11:12] Improved joke
[00:11:14] I populate improve joke
[00:11:16] final joke
[00:11:18] so what's happening is
[00:11:20] I usually these steps, I'm making LLM calls
[00:11:22] and I'm populating
[00:11:24] my state or this
[00:11:26] container in the workflow
[00:11:28] with the output of each
[00:11:30] LLM call. That's really all that's going on.
[00:11:32] Now notice in this workflow there's a gate
[00:11:34] here. So in this case I'm just going to create
[00:11:36] some gating logic. So what's interesting
[00:11:38] is I can take in the state
[00:11:40] and I can just check, hey, does the joke
[00:11:42] have a question mark
[00:11:44] or an exclamation point. That's just some
[00:11:46] arbitrary criteria and what I can
[00:11:48] do is I can pass
[00:11:50] anything I want here
[00:11:52] just two strings, pass
[00:11:54] or fail. Now this can be used as
[00:11:56] conditional edge or gate in
[00:11:58] line graph. So now I
[00:12:00] have a container
[00:12:02] that has everything I want to modify in my workflow.
[00:12:04] I've defined each step
[00:12:06] of my workflow as an independent function.
[00:12:08] I've defined a gate that's
[00:12:10] going to serve as that check
[00:12:12] on the output of the joke
[00:12:14] and now I lay this out in line graph as a simple
[00:12:16] workflow. So all I need to do
[00:12:18] here is just take in my state
[00:12:20] initialize the workflow, add
[00:12:22] those three steps to it. We added
[00:12:24] generate joke, improve joke,
[00:12:26] polish joke and this is where
[00:12:28] I define the connectivity of my
[00:12:30] graph or workflow.
[00:12:32] So I'm going to start. I'm going to go
[00:12:34] generate joke first and you can see
[00:12:36] then I want to check the output
[00:12:38] of my first call to see
[00:12:40] whether or not it has a punch
[00:12:42] line. So I add a conditional edge
[00:12:44] that connects
[00:12:46] generate joke and
[00:12:48] based on the output of this
[00:12:50] function, if it's pass
[00:12:52] I go to improve
[00:12:54] joke. That's my other node.
[00:12:56] If it's fail, I just end.
[00:12:58] Then I create the edges from improve to
[00:13:00] polish, polish to end,
[00:13:02] compile that as a workflow
[00:13:04] and there we go. So that's the exact same
[00:13:06] workflow that they drew out
[00:13:08] in the blog post applied
[00:13:10] to joke generation.
[00:13:12] Now, once I had this workflow, I can very
[00:13:14] simply just run chain dot
[00:13:16] invoke. That's a very simple way to invoke
[00:13:18] any chain workflow
[00:13:20] or whatever you have in line graph.
[00:13:22] I pass in a topic from the user
[00:13:24] and we can see the LLMs create
[00:13:26] an initial joke. They improved
[00:13:28] it and Claude
[00:13:30] creates final joke. So this is a very
[00:13:32] simple example of a chain. Great, so
[00:13:34] we've covered the augment to LLM
[00:13:36] we've covered basic problem chaining
[00:13:38] now let's get into some more interesting
[00:13:40] and complex workflows like
[00:13:42] parallelization. Now let's talk about parallelization
[00:13:44] do this when
[00:13:46] you for example have multiple perspectives
[00:13:48] that you want for single tasks. So I've done this
[00:13:50] quite a bit with things like multi query
[00:13:52] rag. If I have a question I want to
[00:13:54] fan it out into like three or four different sub questions
[00:13:56] or when independent tasks can be performed
[00:13:58] with different prompts or different LLMs.
[00:14:00] So lots of cases where you want to just
[00:14:02] paralyze tasks in workflows.
[00:14:04] So let's just build this. Let's take a topic
[00:14:06] create a joke, story and
[00:14:08] poem all in parallel.
[00:14:10] So in the same way I did before
[00:14:12] I create my state. Again this is just a
[00:14:14] container for everything I'm going to modify in my workflow.
[00:14:16] In this case I'll have a topic from a user
[00:14:18] and I'll have the joke, the story
[00:14:20] the poem and I'll just combine them at the end.
[00:14:22] Now this workflow is going to have
[00:14:24] three LLM calls. They'll run in parallel
[00:14:26] and then one aggregation that'll pull them
[00:14:28] all together. So all I'm going to do is I'm
[00:14:30] going to create a function for each of those
[00:14:32] different steps in my workflow
[00:14:34] LLM call one is going
[00:14:36] to write a joke about the topic
[00:14:38] a story, a poem
[00:14:40] and I'll just aggregate them all
[00:14:42] into a string. Super simple. Now just like I
[00:14:44] showed before we can build this in line graph.
[00:14:46] Pass in that state, the container
[00:14:48] add the nodes
[00:14:50] and just connect them. So in this case I go
[00:14:52] from start to LLM call one
[00:14:54] two three and they all
[00:14:56] connect to the aggregate on the end
[00:14:58] and I can show it. There you go.
[00:15:00] So you have a nice visualization of your workflow
[00:15:02] and I can run it. There we go. So we have a story
[00:15:04] now, a joke and
[00:15:06] a poem all created
[00:15:08] in parallel. So we've covered the augmented LLM
[00:15:10] that's our building block. We talked about prompt chaining. We talked
[00:15:12] about parallelization. Now let's get into
[00:15:14] routing. I've used routing a lot
[00:15:16] and it's extremely useful in a bunch of use cases
[00:15:18] when you want to decide
[00:15:20] for example if you want to only go to one
[00:15:22] of those steps which one to go
[00:15:24] to you can use the LLM to make
[00:15:26] that decision. So a specific example
[00:15:28] of this is I've used routing a lot
[00:15:30] and I've been working with retrieval and taking a question
[00:15:32] and rounding it to different retrieval systems.
[00:15:34] So let's do an example where we take
[00:15:36] an input and we route it to either
[00:15:38] a joke, a story or a poem generation
[00:15:40] based on what the user asks for. Now
[00:15:42] I'm going to show a very nice trick here
[00:15:44] for routing I often like to do this.
[00:15:46] I basically take an LLM
[00:15:48] and I give it
[00:15:50] a structured output. So that guarantees
[00:15:52] the LLM is going to produce
[00:15:54] in this particular case the strings
[00:15:56] poem, story
[00:15:58] or joke as a structured object
[00:16:00] and I'm going to give it
[00:16:02] in this particular case a pedantic model
[00:16:04] just like before I'm going to define my state
[00:16:06] again this is a container
[00:16:08] we'll take an input from the user
[00:16:10] we'll get the decision from our router
[00:16:12] and we'll get
[00:16:14] an output. We'll save that as
[00:16:16] the final output. Now in this case
[00:16:18] for my nodes just like before
[00:16:20] I'm going to have three different LLM calls
[00:16:22] that we'll either write a story
[00:16:24] a joke or a poem
[00:16:26] I have my router which is going to take the user
[00:16:28] input and basically
[00:16:30] decide whether or not to route it
[00:16:32] to story, joke or poem
[00:16:34] based on the content of the input and it's just going
[00:16:36] to return that as a structured object
[00:16:38] and I can extract
[00:16:40] from the
[00:16:42] data model the step decision
[00:16:44] write that to state as decision
[00:16:46] so remember if you look at the model here
[00:16:48] it's just a pedantic
[00:16:50] model which is going
[00:16:52] to output a single key
[00:16:54] step which is either going to be poem, story
[00:16:56] or jokes I extract that from the
[00:16:58] pedantic model that is returned by the router
[00:17:00] and I write that to state so then I
[00:17:02] have my decision in state
[00:17:04] and now this is just going to be a conditional edge
[00:17:06] that'll look at the decision
[00:17:08] and determine what node to go
[00:17:10] to super simple so basically
[00:17:12] if the decision is
[00:17:14] story go to node one
[00:17:16] joke to poem
[00:17:18] three that's it now you'll see
[00:17:20] in this toy example each of these
[00:17:22] steps are doing the same thing
[00:17:24] but in real-world examples
[00:17:26] the router
[00:17:28] will send to different steps that will have
[00:17:30] different logic different alarm calls this is just
[00:17:32] a toy example showing you how to hook up that
[00:17:34] logic between for example
[00:17:36] a router step
[00:17:38] a structured output
[00:17:40] and the decision about where to go next
[00:17:42] cool so this is showing you visualization
[00:17:44] of that you'll see what's kind of nice
[00:17:46] in line graph when we visualize this this dotted line
[00:17:48] means a conditional edge
[00:17:50] so it's going to go to only one of those
[00:17:52] three paths whenever this runs
[00:17:54] and of course that's going to be based upon
[00:17:56] the decision of the router
[00:17:59] now we can look at these node just create a print
[00:18:01] statement that'll just tell us which
[00:18:03] node was visited to confirm
[00:18:05] we can run this cool so
[00:18:07] we know we go to the node that creates a
[00:18:09] joke and we get the joke output
[00:18:11] we've covered the augment elements are building block
[00:18:13] we talked about prompt chaining we talked
[00:18:15] about parallelization we talked about routing
[00:18:17] and I'll stop at another workflow
[00:18:19] orchestrator worker
[00:18:21] now this is a really interesting one and I've used this
[00:18:23] quite a bit as well so this is a case
[00:18:25] where you want an LLM to break down a task
[00:18:27] in a set of sub tasks
[00:18:29] delegate each sub task to an independent worker
[00:18:31] and then synthesize the results
[00:18:33] so it's kind of like parallelization except
[00:18:35] the key differences this worker
[00:18:37] assignment you don't know ahead of time
[00:18:39] so you're having an LLM reason about something
[00:18:41] and then create a bunch of workers based
[00:18:43] upon its reasoning
[00:18:45] so again in this case the LLM
[00:18:47] is kind of gating or creating the control
[00:18:49] flow just like in the case of routing
[00:18:51] so here's an example that I've used quite a bit
[00:18:53] report writing
[00:18:55] maybe you've played with deep research
[00:18:57] and LLM reasons about the
[00:18:59] plan for the report and dynamically
[00:19:01] generates a bunch of report sections
[00:19:03] and then goes in those research and all of them
[00:19:05] classic example of an orchestrator worker type
[00:19:07] workflow so let's actually do that right now
[00:19:09] so for this the
[00:19:11] trick is I'm also going to use structured outputs
[00:19:13] so I'm going to create a data model for
[00:19:15] a report section it's going to have a name
[00:19:17] and a description and I'm going to have a
[00:19:19] list of sections here so what I'm going to do
[00:19:21] is I'm going to bind that section
[00:19:23] list to my LLM
[00:19:25] and that's going to be my planner so what's cool
[00:19:27] here is the planner is going to take
[00:19:29] an input reflect on it and produce
[00:19:31] a list of sections
[00:19:33] based upon its reflection so this is dynamic
[00:19:35] I don't know how many sections it will create
[00:19:37] a priori that's why this is a very good
[00:19:39] orchestrator worker use case now line graph
[00:19:41] looks like before I create my state
[00:19:43] now in this case what I'm going to do is
[00:19:45] I'm going to create a state
[00:19:47] for my orchestrator graph
[00:19:49] which is going to have like a topic from a user
[00:19:51] a list of sections
[00:19:53] a list of completed sections which the workers
[00:19:55] will all write to
[00:19:57] and a final report
[00:19:59] okay so that's state one now this is where
[00:20:01] these get interesting with orchestrator worker
[00:20:03] workflows in line graph
[00:20:05] the way we often like to do it is
[00:20:07] for the workers give them their
[00:20:09] own state so why is this
[00:20:11] because each of those workers you want to handle
[00:20:13] independent inputs
[00:20:15] and they're kind of all self contained
[00:20:17] objects think about as their
[00:20:19] own little buckets
[00:20:21] in which works being done and different
[00:20:23] works being done in each one but they're all
[00:20:25] writing out to the same
[00:20:27] output and this is why
[00:20:29] I include this completed
[00:20:31] sections key in the worker state
[00:20:33] and in the graph states
[00:20:35] what's interesting in line graph is
[00:20:37] when you have overlapping keys
[00:20:39] and you write to for example
[00:20:41] this completed sections key
[00:20:43] in each worker the outer state
[00:20:45] will also have
[00:20:47] that update reflected so what's going to
[00:20:49] happen is all the workers going to write
[00:20:51] to this completed sections key in
[00:20:53] parallel and we structure
[00:20:55] this key with
[00:20:57] an annotation that allows
[00:20:59] for the addition of new
[00:21:01] elements so that's really all we
[00:21:03] need to do so here I'm going to create a work
[00:21:05] an orchestrator and this is basically
[00:21:07] going to be my planner I'm going to invoke it
[00:21:09] with the input
[00:21:11] topic from the user and I'm going to
[00:21:13] tell it to create a plan then I'm
[00:21:15] going to have this LLM call which is my worker
[00:21:17] it takes in the worker state
[00:21:19] and it basically
[00:21:21] says write a report section
[00:21:23] and that's all I need and I just pass
[00:21:25] it the section name
[00:21:27] and section description and this completed sections
[00:21:29] is a state key that
[00:21:31] all the workers can
[00:21:33] write to in parallel that's
[00:21:35] the key point and all those sections are
[00:21:37] going to be accumulated in
[00:21:39] that completed sections key then we have a synthesizer
[00:21:41] that's going to read out the
[00:21:43] completed sections and just write them all
[00:21:45] out as a string that's it
[00:21:47] write that to the final report key in
[00:21:49] my state now this is the
[00:21:51] only thing that's new a little bit special
[00:21:53] an orchestrator worker style work flows
[00:21:55] because it's so common
[00:21:57] we have a special
[00:21:59] API called send in line graph
[00:22:01] that allows you to basically spawn these workers
[00:22:03] dynamically
[00:22:05] and what's happening is remember
[00:22:07] my planner wrote the sections of the
[00:22:09] port to the state and I
[00:22:11] can iterate through those sections
[00:22:13] and I can basically assign each section
[00:22:15] to an independent worker just
[00:22:17] like this for each section
[00:22:19] in sections send
[00:22:21] to LLM call
[00:22:23] that's my worker
[00:22:25] and basically initialize the
[00:22:27] state as section
[00:22:29] when I do that so then
[00:22:31] that LLM call you can see receives
[00:22:33] worker state and
[00:22:35] it's receiving from state the
[00:22:37] section name
[00:22:39] and description and then it goes and writes
[00:22:41] that section it writes it output
[00:22:43] to completed sections which
[00:22:45] my orchestrator has access to
[00:22:47] and then the synthesizer basically just grabs
[00:22:49] completed sections and combines
[00:22:51] them that's it you're done that's
[00:22:53] all I need to do now I can build this workflow
[00:22:55] and there we go so this dotted line
[00:22:57] just shows you that you use the send API
[00:22:59] to spawn a whole bunch of LLM
[00:23:01] call workers you don't know how many
[00:23:03] I have time that's why it doesn't draw out each
[00:23:05] one specifically it's going to be dynamically
[00:23:07] determined based upon the orchestrator's
[00:23:09] plan that's the key characteristic
[00:23:11] of these orchestrator worker workflows
[00:23:13] you don't know a priori how many
[00:23:15] workers you need the LLM will
[00:23:17] determine that on the fly now let's
[00:23:19] show an example of this I want
[00:23:21] a report on LLM
[00:23:23] scaling logs so what's kind of cool is
[00:23:25] this runs fairly quickly you can
[00:23:27] see the planner generate all
[00:23:29] these report sections great
[00:23:31] and I can look at the final report it can
[00:23:33] catnate some all together and you can see
[00:23:35] I get this rich introduction and then I
[00:23:37] get you know fundamental scaling
[00:23:39] relationships following the plan now
[00:23:41] in reality when I do this
[00:23:43] I have much more detail prompts I showed
[00:23:45] here this is really showing you the workflow
[00:23:47] rather than the particulars of how I
[00:23:49] build a high quality report writer in fact
[00:23:51] I have separate videos on report writing you
[00:23:53] could check out but this is just showing
[00:23:55] how I set up an orchestrator worker
[00:23:57] style of workflow
[00:23:59] nobody's talking about the orchestrator
[00:24:01] worker workflow
[00:24:03] let's talk about something that's a bit related
[00:24:05] the evaluator optimizer workflow in both
[00:24:07] these cases you're going to have LLM
[00:24:09] directing the control flow
[00:24:11] through predefined code paths
[00:24:13] we have one LLM
[00:24:15] general response and another kind of
[00:24:17] grade it and give feedback in a loop
[00:24:19] now I've used us quite a bit for
[00:24:21] example grading responses from a rag
[00:24:23] and for hallucinations or for factual
[00:24:25] accuracy I've used kind of like
[00:24:27] kind of evaluator gates
[00:24:29] and if for example there's hallucination
[00:24:31] in the output that isn't grounded by the
[00:24:33] documents I send it back and have a regenerate
[00:24:35] response and here I'm going
[00:24:37] to use structured outputs again you see
[00:24:39] there's kind of a trend here structured
[00:24:41] outputs is like kind of all you
[00:24:43] need and quotes it's extremely
[00:24:45] convenient you can really build all these
[00:24:47] workflows just with structured outputs you don't
[00:24:49] have to use tool calling for example
[00:24:51] routers so basically conditionally
[00:24:53] determine where to go next you can
[00:24:55] have then nodes that for example just call
[00:24:57] tools depending on the result of the router
[00:24:59] itself so really just structured
[00:25:01] outputs is a nice way you can build
[00:25:03] a lot of complex workflows in this
[00:25:05] case I'm going to create a structured output
[00:25:07] that's basically my my grader model
[00:25:09] that's going to be grade
[00:25:11] and feedback the side of the joke is funny
[00:25:13] or not in my case and
[00:25:15] if it is not funny
[00:25:17] give some feedback okay so that's going to be my
[00:25:19] evaluator and again I'm going to find the
[00:25:21] graph state in this case I'm going to take a
[00:25:23] joke based upon a topic from a user I'll
[00:25:25] generate the joke and then I'll grade it
[00:25:27] is give it feedback determine if it's
[00:25:29] funny or not based on the feedback
[00:25:31] I'll go back regenerate a new joke
[00:25:33] that's it nice and simple
[00:25:35] so this is going to be my generator
[00:25:37] it's going to generate a joke now
[00:25:39] you'll see something kind of interesting here
[00:25:41] I'm going to check if there's feedback
[00:25:43] in the state okay
[00:25:45] now there might be because I've
[00:25:47] basically looped back to this node
[00:25:49] if I determine that the joke is not
[00:25:51] good so there may be feedback in the state
[00:25:53] if there's feedback I include in my prompt
[00:25:55] otherwise I just say write a joke
[00:25:57] about the topic so nice and easy
[00:25:59] and then I have an evaluator
[00:26:01] that basically takes in the joke
[00:26:03] from state and grades it
[00:26:05] again this evaluator has structured
[00:26:07] output so it'll basically produce
[00:26:09] a grade and some feedback and then
[00:26:11] I have an additional edge that'll look
[00:26:13] at state funny or not
[00:26:15] so again that's like kind of my grade
[00:26:17] and if it's funny
[00:26:19] route to accepted if it's not funny
[00:26:21] route to rejected in feedback
[00:26:23] so again this is the conditional edge
[00:26:25] I use to determine where to go next
[00:26:27] just like we saw with routing build my graph
[00:26:29] and you can see as everything we want here
[00:26:31] here's the generator here is the evaluator
[00:26:33] based on the evaluator we either go
[00:26:35] back and again
[00:26:37] you can see we set that conditional edge up right here
[00:26:39] so that route joke conditional
[00:26:41] edge we just talked about it
[00:26:43] if it's funny or not if it's funny we go to
[00:26:45] accepted so if accepted
[00:26:47] we go to end
[00:26:49] if it is rejected in feedback
[00:26:51] we go back to lm call generate
[00:26:53] you can see when you set the conditional edge
[00:26:55] this is how you can basically route
[00:26:57] from the output of your
[00:26:59] logic your edge logic
[00:27:01] to the next node
[00:27:03] to go to that's it
[00:27:05] extremely simple and you can see get a nice
[00:27:07] visualization of it so
[00:27:10] let's give this a shot run it with an input of
[00:27:12] that's so you get the output of the joke
[00:27:14] and we actually can look at the state to see
[00:27:16] what the feedback was so
[00:27:18] state feedback in this case
[00:27:20] it seems to like it and
[00:27:22] let's check
[00:27:24] funny or not and it turns out it's funny
[00:27:26] okay so our grader liked the joke we went ahead
[00:27:28] and returned it then to the user we ended
[00:27:30] and so we can see that the grader
[00:27:32] was initiated
[00:27:34] and decided to like the joke so it passes
[00:27:36] and we finish so we talked about a number of
[00:27:38] different workflows that use lm's
[00:27:40] within some kind of reasoning scaffolding
[00:27:42] and in the case of orchestrator worker
[00:27:44] evaluator optimizer
[00:27:46] routing
[00:27:48] you actually do let the lm make decisions
[00:27:50] to route the control flow through that scaffolding
[00:27:52] now let's
[00:27:54] remove the scaffolding and let's talk about
[00:27:56] agents with agents you're simply allowing
[00:27:58] an lm to form actions
[00:28:00] and form tool calls
[00:28:02] and directly receive the output
[00:28:04] or feedback from those actions
[00:28:06] and so in the workflow case we talked
[00:28:08] about there are always kind of these predefined
[00:28:10] code paths that we had
[00:28:12] and lm kind of follow
[00:28:14] and kind of route
[00:28:16] through in the case of an agent
[00:28:18] we've removed those
[00:28:20] now when do you actually need an agent this is
[00:28:22] kind of the big question you see agents
[00:28:24] being used in cases where
[00:28:26] you really have open-ended problems
[00:28:28] that you cannot easily capture
[00:28:30] in a workflow for example
[00:28:32] you want lm
[00:28:34] to utilize different
[00:28:36] tools in
[00:28:38] a pattern that you just cannot predict
[00:28:40] that priori so it's not easy to land in a workflow
[00:28:42] so it's kind of open-ended task
[00:28:44] we've seen some really interesting examples
[00:28:46] of challenges like sweep bench
[00:28:48] so a benchmark for software engineering
[00:28:50] in which anthropic actually use
[00:28:52] a agent's architecture just shown like this
[00:28:54] and it's used very strong performance
[00:28:56] so we know for certain
[00:28:58] open-ended tasks agents are appropriate
[00:29:00] I do want to caveat in the
[00:29:02] event that lm's
[00:29:04] extremely proficient at
[00:29:06] tool calling it's also possible
[00:29:08] that a lot of the scaffolding that we talked
[00:29:10] about with various workflows is unnecessary
[00:29:12] today
[00:29:14] if you know
[00:29:16] roughly the sequence tools need to be
[00:29:18] initiated it's often better
[00:29:20] to capture in a workflow in terms of reliability
[00:29:22] then just give it to an agent let the agent
[00:29:24] hopefully call that
[00:29:26] correct sequence now let's just set up an lm
[00:29:28] with tools I'm going to give it multiply add and
[00:29:30] divide nice and simple now I'm going to find
[00:29:32] three nodes so
[00:29:34] I'm going to call my lm and I'm going to
[00:29:36] basically allow
[00:29:38] the lm to call a tool
[00:29:40] okay so I'm using my lm
[00:29:42] with tools and in this particular
[00:29:44] case I'm saying you're a helpful assistant
[00:29:46] tasked with performing arithmetic so the output
[00:29:48] of that tool call is going to be saved to this
[00:29:50] messages key in our state so what's happening
[00:29:52] is my state has a single
[00:29:54] key in this particular case messages
[00:29:56] which is going to accumulate what I pass
[00:29:58] as the user what the lm
[00:30:00] produces and so forth what's
[00:30:02] going to happen is I have another node
[00:30:04] called tool node it's going to look at
[00:30:06] the state look at the last message
[00:30:08] determine if it's a tool call
[00:30:10] if it is it'll go ahead
[00:30:12] and just call that tool
[00:30:14] that's it nice and simple
[00:30:16] and it's going to return that
[00:30:18] to state so what's
[00:30:20] interesting here is I'm going to have a sequence
[00:30:22] of human input
[00:30:24] model agent in this case
[00:30:26] the size to call tool
[00:30:28] this tool node looks
[00:30:31] and sees oh the lm decided to call
[00:30:33] a tool it actually runs
[00:30:35] that tool call that then is
[00:30:37] written to state messages
[00:30:39] as a tool message
[00:30:41] this is that environmental feedback
[00:30:43] thing you hear about so you talk about agents
[00:30:45] they can perform actions that's the tool
[00:30:47] call done up here fine they also can
[00:30:49] receive feedback from the environment
[00:30:51] and act on it that is the
[00:30:53] output of this tool node this tool node is basically the
[00:30:55] environmental feedback saying here's the output
[00:30:57] tool call the lm then
[00:30:59] will get that decide what to do next
[00:31:01] that's it that's
[00:31:03] an agent now the only other thing I need
[00:31:05] is conditional edge that basically says
[00:31:07] was the
[00:31:09] last message a tool
[00:31:11] call if so
[00:31:13] I'm going to go ahead and route
[00:31:15] to the tool node and if
[00:31:17] not I will end so
[00:31:19] you know you can modify this in different ways
[00:31:21] but a lot of times people basically just say allow
[00:31:23] the agent can continue making tool calls until
[00:31:25] it decides it doesn't need one anymore and then you
[00:31:27] don't and then you're done so there we are I mean
[00:31:29] that's our agent loop that you know and that's kind
[00:31:31] of why agents are elegant they're
[00:31:33] extremely simple in this kind of formulation
[00:31:35] all it is it's basically
[00:31:37] an lm initially with a bunch of tools
[00:31:39] and it's like a
[00:31:41] tool node that will run the
[00:31:43] tool for you and return that environmental
[00:31:45] feedback to the lm and
[00:31:47] let the lm keep spinning
[00:31:49] until it decides you don't need a tool call anymore than
[00:31:51] you're done that's really it now again this tool
[00:31:53] call thing thing about those actions so this lm
[00:31:55] can perform actions
[00:31:57] the actions are determined by the user so you can pass
[00:31:59] in any set of tools to this lm
[00:32:01] it decides to perform those actions
[00:32:03] they need some system that actually does
[00:32:05] those actions so that's like that's what we
[00:32:07] create with this tool node and this
[00:32:09] just loops until the lm says I don't need
[00:32:11] a tool call anymore and then that conditional
[00:32:13] edge says okay
[00:32:15] I can just send that's really it so let's see an example
[00:32:17] of that I'm going to basically
[00:32:19] tell this agent
[00:32:21] add 3 and 4 then take the output
[00:32:23] and multiply by 4
[00:32:25] okay now look
[00:32:27] this is extremely simple and lm can just do this
[00:32:29] I totally get it this is more showing you
[00:32:31] the principle setting up an agent
[00:32:33] with these tools for addition
[00:32:35] and multiplication and testing
[00:32:37] whether or not it can correctly perform these tool
[00:32:39] calls in sequence and
[00:32:41] looking at the flow
[00:32:43] of messages so
[00:32:45] here we go this is pretty cool now again
[00:32:47] this is like a toy example
[00:32:49] but that's showing you the flow and that's what matters
[00:32:51] you have an input from the human
[00:32:53] my instructions the lm looks at that
[00:32:55] and says okay I need to make a tool call
[00:32:57] makes a tool call the tool node
[00:32:59] executes the tool call
[00:33:01] returns environmental feedback
[00:33:03] to my lm
[00:33:05] as the result of the tool call which is
[00:33:07] 7 my agent thinks about
[00:33:09] it makes another tool call responds with 28
[00:33:11] agent thinks about it final result is
[00:33:13] 28 here's how we got there no more tool calls
[00:33:15] needed done for all the
[00:33:17] hypo by agents that's all this extremely simple
[00:33:19] is tool calling in a loop now
[00:33:21] again why don't we just do this
[00:33:23] because look a lot of problems
[00:33:25] can be solved with workflows which are a bit simpler
[00:33:27] agents haven't been particularly
[00:33:29] reliable to date particularly with large
[00:33:31] numbers of tools or complex trajectories
[00:33:33] of tool calls and so a lot of people actually
[00:33:35] in production prefer workflows I've done
[00:33:37] a lot more workflows than agents to be honest
[00:33:39] over the last year or two but
[00:33:41] I completely acknowledge in the event that you have
[00:33:43] very capacity reasoning models that
[00:33:45] can perform low latency
[00:33:47] high quality tool calling
[00:33:49] and we have more
[00:33:51] kind of confidence that they can perform
[00:33:53] reliably in production I think you will see the movement
[00:33:55] to this classic style
[00:33:57] of very simple
[00:33:59] tool calling agent in production
[00:34:01] but the game in the field today is a little bit more
[00:34:03] like people are saying well
[00:34:05] I want to put workflows into production because
[00:34:07] they're a little bit more trustworthy again I some
[00:34:09] scaffolding around the
[00:34:11] core kind of LLM calls
[00:34:13] now I do also want to show
[00:34:15] this is looking at the documentation
[00:34:17] that we do have a pre-built method
[00:34:19] called create react agent that basically
[00:34:21] wraps what we just built from scratch
[00:34:23] right here for convenience
[00:34:25] now it's depends
[00:34:27] if you want to build it from scratch
[00:34:29] yourself just as we did that is completely fine
[00:34:31] if you want to use the pre-built method
[00:34:33] that's fine as well but it's available to
[00:34:35] you and I will be sharing
[00:34:37] the link to this tutorial
[00:34:39] page which has everything we just went through
[00:34:41] so all the different
[00:34:43] workflows we talked through are all
[00:34:45] in this tutorial which I will be sharing
[00:34:47] but just from this little tutorial
[00:34:49] you've seen here's how you can lay out all the different
[00:34:51] workflows and
[00:34:53] an agent all in Langrath
[00:34:55] if I go back to the why
[00:34:57] Langrath story, what you go with Langrath
[00:34:59] is when you compile
[00:35:01] those workflows or agent in Langrath
[00:35:03] you're getting a persistence layer for free
[00:35:05] which gives you short and long-term memory
[00:35:07] and that also gives you the ability to stop
[00:35:09] interruptions, review
[00:35:11] and continue i.e.
[00:35:13] human loop it gives you a whole
[00:35:15] bunch of streaming capacities you can
[00:35:17] stream independent values from your state at any point
[00:35:19] in time you can stream of course
[00:35:21] tokens out of LM calls
[00:35:23] and you also get deployment so we
[00:35:25] have a very nice and easy on ramp
[00:35:27] for testing debugging and deploying any
[00:35:29] of these so you could take any of those
[00:35:31] workflows or agents we just built and deploy
[00:35:33] them in like five minutes so
[00:35:35] very very quickly that's really what you're getting
[00:35:37] out of the framework and
[00:35:39] you can also see with Langrath it's pretty easy
[00:35:41] to lay them out and actually working on making
[00:35:43] it even easier so we're trying to reduce
[00:35:45] the overhead so you can lay it out almost
[00:35:47] as if you're writing Python you're not even thinking
[00:35:49] about the framework but again these benefits
[00:35:51] kind of for free when you do
[00:35:53] use the framework that's kind of the big idea here
[00:35:55] so hopefully this was a helpful overview
[00:35:57] to present
[00:35:59] how to lay these various workflows
[00:36:01] or agents out using Langrath
[00:36:03] and what benefits you may get from Langrath
[00:36:05] as a consideration so thanks very much
[00:36:07] feel free to leave any comments below
