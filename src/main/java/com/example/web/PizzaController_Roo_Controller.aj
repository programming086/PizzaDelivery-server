// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.example.web;

import com.example.domain.Pizza;
import com.example.web.PizzaController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect PizzaController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String PizzaController.create(@Valid Pizza pizza, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, pizza);
            return "pizzas/create";
        }
        uiModel.asMap().clear();
        pizza.persist();
        return "redirect:/pizzas/" + encodeUrlPathSegment(pizza.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String PizzaController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Pizza());
        return "pizzas/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String PizzaController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("pizza", Pizza.findPizza(id));
        uiModel.addAttribute("itemId", id);
        return "pizzas/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String PizzaController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("pizzas", Pizza.findPizzaEntries(firstResult, sizeNo));
            float nrOfPages = (float) Pizza.countPizzas() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("pizzas", Pizza.findAllPizzas());
        }
        return "pizzas/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String PizzaController.update(@Valid Pizza pizza, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, pizza);
            return "pizzas/update";
        }
        uiModel.asMap().clear();
        pizza.merge();
        return "redirect:/pizzas/" + encodeUrlPathSegment(pizza.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String PizzaController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Pizza.findPizza(id));
        return "pizzas/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String PizzaController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Pizza pizza = Pizza.findPizza(id);
        pizza.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/pizzas";
    }
    
    void PizzaController.populateEditForm(Model uiModel, Pizza pizza) {
        uiModel.addAttribute("pizza", pizza);
    }
    
    String PizzaController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
